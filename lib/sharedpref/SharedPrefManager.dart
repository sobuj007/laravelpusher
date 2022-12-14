
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/userModel.dart';


class SharedPrefKeys{
static final String USER = "USER";
  static const String USERTOKEN = "TOKEN";
  static const String USERLANG = "USERLANG";
 static const String USERINFO = "USERINFO";

  static const String ISUSERLOGIN = "ISUSERLOGIN";
  static const String ISUSERFIRST = "ISUSERFIRST";
  static const String ISTHEMEDARK = "ISTHEMEDARK";
  static const String ISTHEMECOLOR = "ISTHEMECOLOR";
}


class SharedPrefManager{

  static Future <bool> setUserLogin(data)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setBool("ISUSERLOGIN", data);
  }
  static Future<bool?> isUserLogin()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefKeys.ISUSERLOGIN);
  }
  static Future <bool> setUserFirst(data)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setBool("ISUSERFIRST", data);
  }
  static Future<bool?> isUserFirst()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefKeys.ISUSERFIRST);
  }
  static Future<dynamic> setToken(data)async{
    SharedPreferences pref= await  SharedPreferences.getInstance();
   return pref.setString('USERTOKEN', data);
  }
 Future<dynamic> getToken()async{
    SharedPreferences pref= await  SharedPreferences.getInstance();
   return pref.getString('USERTOKEN');
  }
static setUser(UserModel data)async{
    SharedPreferences pref= await  SharedPreferences.getInstance();
    String d= json.encode(data);
   return pref.setString("USER", d);
  }
static Future<dynamic> getUserDataProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var d= pref.getString("USER");
    return UserModel.fromJson(json.decode(d!));
  }

Future<void> logut()async{
SharedPreferences pref= await  SharedPreferences.getInstance();
pref.clear();

}
}