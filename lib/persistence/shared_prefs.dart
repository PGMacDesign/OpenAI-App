import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//region Setters

//Save a string value to shared prefs
Future<void> saveString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}
//Save a list of strings to shared prefs
Future<void> saveList(String key, List<String> value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);
}

//Save an integer value to shared prefs
Future<void> saveInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

//Save dynamic value to shared prefs
Future<void> saveDouble(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

//Save a boolean value to shared prefs
Future<void> saveBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

//Save dynamic values to shared prefs
Future<void> saveAny(Map<String, dynamic> map) async {
  for(String entry in map.keys){
    var x = map[entry];
    switch(x.runtimeType){
      case String:
        saveString(entry, x);
        break;

      case int:
        saveInt(entry, x);
        break;

      case double:
        saveDouble(entry, x);
        break;

      default:
        String jsonString = jsonEncode(x);
        saveString(entry, jsonString);
        break;
    }
  }
}

//Save dynamic value to shared prefs
Future<void> save(String key, dynamic value) async {
  switch(value.runtimeType){
    case String:
      saveString(key, value);
      break;

    case int:
      saveInt(key, value);
      break;

    case double:
      saveDouble(key, value);
      break;

    default:
      String jsonString = jsonEncode(value);
      saveString(key, jsonString);
      break;
  }
}

//endregion

//region Getters

//Retrieve a string value from Shared Prefs
Future<String?> getString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? x = prefs.getString(key);
  return x;
}

//Retrieve a list of strings from Shared Prefs
Future<List<String>?> getList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? x = prefs.getStringList(key);
  return x;
}

//Retrieve an integer value from Shared Prefs
Future<int?> getInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? x = prefs.getInt(key);
  return x;
}

//Retrieve a double value from Shared Prefs
Future<double?> getDouble(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double? x = prefs.getDouble(key);
  return x;
}

//Retrieve a boolean value from Shared Prefs
Future<bool?> getBool(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? x = prefs.getBool(key);
  return x;
}

//Retrieve a dynamic value from Shared Prefs
Future<dynamic> get(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? var0 = prefs.getString(key);
  if(var0 != null){
    return var0;
  }
  bool? var1 = prefs.getBool(key);
  if(var1 != null){
    return var1;
  }
  double? var2 = prefs.getDouble(key);
  if(var2 != null){
    return var2;
  }
  int? var3 = prefs.getInt(key);
  if(var3 != null){
    return var3;
  }
  List<String>? var4 = prefs.getStringList(key);
  if(var4 != null){
    return var4;
  }

  return null;
}



//endregion
