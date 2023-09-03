import 'package:fidenz_flutter_boilerplate/utility/shared_preference/SharedPreferences.dart';

import 'DataType.dart';



class FidenzSharedPreferenceUtility{

  static SharedPreferences? sharedPreferences = null;

 static _init() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
  }


  // set shared preferences based on data type.
 static setData(DataType dataType, String key, var value) async {

   await _init();

    switch (dataType) {
      case DataType.string:
        await sharedPreferences!.setString(key, value);
        break;
      case DataType.bool:
        if ([null, ""].contains(value)) {
          await sharedPreferences!.setBool(key, false);
        } else {
          await sharedPreferences!.setBool(key, value);
        }
        break;
      case DataType.int:
        await sharedPreferences!.setInt(key, value);
        break;
      default:
        await sharedPreferences!.setString(key, value);
        break;
    }
  }

  //get shared preferences based on string data with key.
  static getStringData(String key) {
    _init();
    return sharedPreferences!.getString(key);
  }

  //get shared preferences based on int data with key.
  static  getIntData(String key) {
    _init();
    return sharedPreferences!.getInt(key);
  }

  //get shared preferences based on int data with key.
  static getBoolData(String key) {
    _init();
    return sharedPreferences!.getBool(key);
  }

}