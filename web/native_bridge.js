function setValues(dataToSet) {
    String val = "default text"
    try {
     if (dataToSet != null) {
        val = dataToSet
     }
     return val
     }
    catch (e) {
        console.log(`NativeFlutterInterface not found !`);
    }


}
