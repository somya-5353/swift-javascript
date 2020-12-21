@JS()
library t;

import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'dart:js' as js;

const String flutterWeb = 'This message is being sent from Flutter';
String sum = 'Welcome to flutter';
int result = 0;


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();


  js.context['functionFromNative'] = () {
    return flutterWeb;
  };

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<void> _initNativeProperties() async {
    js.context['addTwoNumbers'] = (num1, num2) {
      result =  num1+num2;
      sum = (num1+num2).toString();
      return sum;
    };
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String message) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<void>(
          future: _initNativeProperties(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text(
                          sum,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        child: Text('SUM'),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {

                          });
                        },
                      )
                    ],
                  ),
                );
              default:
                return CircularProgressIndicator(
                );
            }
          },
        ),
      ),
    );
  }
}
