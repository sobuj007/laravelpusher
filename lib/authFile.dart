import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavalpuser/api.dart';
import 'package:lavalpuser/main.dart';
import 'package:lavalpuser/model/chatModel.dart';
import 'package:lavalpuser/sharedpref/SharedPrefManager.dart';
import 'package:quickalert/quickalert.dart';

class AuthFile {
  headerfile(token) => {
        'Accept': 'Application/json',
        //'Content-type':'Application/json',
        'Authorazation': 'Bearer $token'
      };

  logMeout(context) async {
    var token = await SharedPrefManager().getToken();
    print(token);
    var res = await http.post(Uri.parse(Api.logOut), headers: {
      'Accept': 'Application/json',
      //'Content-type':'Application/json',
      'Authorization': 'Bearer $token'
    });
    SharedPrefManager().logut();
    var jrespons = json.decode(res.body);
    print(jrespons);
    if (res.statusCode == 200) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Logout Success",
          autoCloseDuration: Duration(seconds: 2));
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => Login()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Somting Worng")));
    }
  }

  getUserChat() async {
    var token = await SharedPrefManager().getToken();
    print(token);
    var res = await http.get(
      Uri.parse(Api.getChatList),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

  
    var jrespons = json.decode(res.body);
    if (!jrespons['error']) {
    dynamic chats= [];

      try {
        for (var i in jrespons['chats']) {
          // Chats chat=Chats.fromJson(jrespons['chats']);
          Chats chat = Chats(
            id: i["id"],
            createdBy: i["created_by"],
            name: i["name"],
            isPrivate: i["is_private"],
            createdAt: DateTime.parse(i["created_at"]),
            updatedAt: DateTime.parse(i["updated_at"]),
            
            lastMessage: LastMessage.fromJson(i["last_message"]),
            participants: List<Participant>.from(
                i["participants"].map((x) => Participant.fromJson(x))),
          );
       
         chats.add(chat);
        print(" from loop${i["last_message"]}");
        } 
      } catch (e) {
        print(e);
      }
 print(chats);
      return chats;
    }
  }
  getSingelChat(id,page) async {
    var token = await SharedPrefManager().getToken();
    print(token);
    var res = await http.get(
      Uri.parse(Api.getSingelChat+"chat_id=$id&page=$page"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

  
    var jrespons = json.decode(res.body);
    print(jrespons);
    if (!jrespons['error']) {
    dynamic chats= [];

      try {
        // for (var i in jrespons['chats']) {
        //   // Chats chat=Chats.fromJson(jrespons['chats']);
        //   Chats chat = Chats(
        //     id: i["id"],
        //     createdBy: i["created_by"],
        //     name: i["name"],
        //     isPrivate: i["is_private"],
        //     createdAt: DateTime.parse(i["created_at"]),
        //     updatedAt: DateTime.parse(i["updated_at"]),
            
        //     lastMessage: LastMessage.fromJson(i["last_message"]),
        //     participants: List<Participant>.from(
        //         i["participants"].map((x) => Participant.fromJson(x))),
        //   );
       
        //  chats.add(chat);
        // print(" from loop${i["last_message"]}");
        // } 
      } catch (e) {
        print(e);
      }
//  print(chats);
      return chats;
    }
  }
}
