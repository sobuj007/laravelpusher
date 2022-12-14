import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref{
  static  Future<SharedPreferences>getInstance()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref;
  }
  static Future<void>clear()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.clear();
  }
}