import 'dart:convert';
import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:lavalpuser/api.dart';
import 'package:lavalpuser/fonts/fonts.dart';
import 'package:lavalpuser/model/userModel.dart';
import 'package:lavalpuser/sharedpref/SharedPrefManager.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'chat.dart';

Fonts fonts= Fonts();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 //SharedPrefManager().logut();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  checkUserIsLogin();
  }
  checkUserIsLogin()async{
 var token=await SharedPrefManager().getToken();

 if(token!=null){
Navigator.push(context, MaterialPageRoute(builder: (_)=>Chat(token: token,)));

 }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      hintText: 'Enter your Mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: pass,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      hintText: 'Enter your Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        checkLogin();
                        // /  message();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkLogin() async {
    var url = Api.login.toString();
    var res = await http.post(Uri.parse(url), headers: {
      // 'Authorazation': '',
      //'Content-type':'Application/json',
      'Accept': 'Application/json'
    }, body: {
      'email': email.text.toString(),
      'password': pass.text.toString(),
    });
    var jresponsive = json.decode(res.body);
print(jresponsive);

    if (jresponsive['error']== false) {
      SharedPrefManager.setToken(jresponsive['token']);
      UserModel user = UserModel.fromJson(jresponsive['user']);

      SharedPrefManager.setUser(user);

      var token = jresponsive['token'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Chat(
                    token: token,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Somting worng"),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }

  message() {
    // return  QuickAlert.show(
    //  context: context,
    //  type: QuickAlertType.success,
    //  text: 'Transaction Completed Successfully!',
    // );
    showDialog(
        context: context,
        builder: (_) {
          return Container(
            width: 80,
            child: AlertDialog(
              actions: [
                Container(
                    height: 250,
                    color: Colors.amber,
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Center(child: Text("lol")),
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
