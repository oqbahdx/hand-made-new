import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
class SharedPref {
  static SharedPreferences pref;
  static dynamic getData({@required String key}) async {
    pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static Future<bool> saveData(

      {@required String key, @required dynamic value}) async {
    pref = await SharedPreferences.getInstance();
    if (value is String) return await pref.setString(key, value);
    if (value is int) return await pref.setInt(key, value);
    if (value is bool)
      return await pref.setBool(key, value);
    else
      return await pref.setDouble(key, value);
  }


  static  removeData({@required String key})async{
    pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }


}

String token = '';
String uId = "";

