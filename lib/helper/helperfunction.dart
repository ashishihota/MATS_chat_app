import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String sharedPrefrenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefrenceUserNameKey = "USERNAMEKEY";
  static String sharedPrefrenceUesrEmailKey = "USEREMAILKEY";

  // savind data to SharedPrefrence
  // using future cause this perticular thing is going to take some time
  // we are waiting to get the data from the server, otherwise it will be null
  static  Future<void> saveUserLoggedInSharedPrefrence(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefrenceUserLoggedInKey, isUserLoggedIn);
  }
  static  Future<void> saveUserNameSharedPrefrence(String userName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrenceUserNameKey, userName);
  }
  static  Future<void> saveUserEmaileSharedPrefrence(String userEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrenceUesrEmailKey, userEmail);
  }


  // Getting the data from the SharedPrefrence
  static  Future<bool> getUserLoggedInSharedPrefrence() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPrefrenceUserLoggedInKey);
  }

  static  Future<String> getUserNameSharedPrefrence() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefrenceUserNameKey);
  }

  static  Future<String> getUserEmaileSharedPrefrence() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefrenceUesrEmailKey);
  }
}