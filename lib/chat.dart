import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lavalpuser/authFile.dart';
import 'package:lavalpuser/laravelecho/laravel_echo.dart';
import 'package:lavalpuser/main.dart';
import 'package:lavalpuser/model/userModel.dart';
import 'package:lavalpuser/sharedpref/SharedPrefManager.dart';
import 'package:pusher_client/pusher_client.dart';

class Chat extends StatefulWidget {
  final token;
  const Chat({super.key, this.token});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late PusherClient pusher;
  late Channel channel;
  var user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    print(widget.token);
    LaravelEcho.init(token: widget.token);
  }

  Future<void> getUser() async {
    UserModel u = await SharedPrefManager.getUserDataProfile();
   

    setState(() {
      user = u;
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (user == null) {
      await getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  user == null ? "" : user.name.toString(),
                  style: fonts.h4bold(),
                ),
                GestureDetector(
                  onTap: () {
                    AuthFile().logMeout(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.logout),
                  ),
                )
              ],
            ),
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * .8),
      ),
      body: Container(
        child: Column(
          children: [
            chatlits()
          ],
        ),
      ),
    );
  }

  chatlits(){
    return Expanded( 
              child: FutureBuilder(
                future: AuthFile().getUserChat(),
                builder: (context, AsyncSnapshot snapshot) {
                 if(snapshot.hasData){
                   return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                       
                        var participant={};
                        //var lastmsg=;
                        print(snapshot.data[index].lastmessage);
                     
                        if(snapshot.data[index].participants[0].user.id==user.id){
                       
                          participant['name']=snapshot.data[index].participants[1].user.name;
                          participant['img']=snapshot.data[index].participants[1].user.thumbnail;
                          
                        }else{
                          participant['name']=snapshot.data[index].participants[0].user.name;
                          participant['img']=snapshot.data[index].participants[0].user.thumbnail;
                        }

                        return ListTile(
                         leading: CircleAvatar(backgroundImage:NetworkImage(participant['img'])),
                          title: Text(participant['name'],style: TextStyle(color: Colors.black),),
                          subtitle: Text(snapshot.data[index].id.toString())
                        );
                      });
                 }
                 else{
                 return CircularProgressIndicator();
                 }
                },
              ),
            );
  }
}
