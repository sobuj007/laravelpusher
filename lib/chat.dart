import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lavalpuser/authFile.dart';
import 'package:lavalpuser/chat/chatRoom.dart';
import 'package:lavalpuser/laravelecho/laravel_echo.dart';
import 'package:lavalpuser/main.dart';
import 'package:lavalpuser/model/userModel.dart';
import 'package:lavalpuser/sharedpref/SharedPrefManager.dart';
import 'package:lavalpuser/styles/colors.dart';
import 'package:lavalpuser/xtrawidget/oneSignalConfig.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
    OneSignalConfig().intOnsignal();

  }
  sendUserTeg(int userId){
    OneSignal.shared.sendTag("userId", userId.toString()).then((value) {
      print("Successfully sent tags with respons : $value");
    }).catchError((e){
      print(e);
    });
  }



  Future<void> getUser() async {
    UserModel u = await SharedPrefManager.getUserDataProfile();
   

    setState(() {
      user = u;
          sendUserTeg(user.id);
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
            height: 50,
            color: Colors.blue[900],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Container(child: Row(children: [ user==null?CircleAvatar(backgroundColor: Colors.grey,):CircleAvatar(radius: 25,backgroundImage: NetworkImage(user.thumbnail),),
                  Text(
                    user == null ? "" : user.name.toString(),
                    style: fonts.h4bold(ColorsData.white),
                  ),],),),
                  GestureDetector(
                    onTap: () {
                      AuthFile().logMeout(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.logout,color: ColorsData.white,),
                    ),
                  )
                ],
              ),
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
                 if(snapshot.hasData){var participant={};
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                         
                          
                         // var lastmsg=json.decode(snapshot.data[index].lastMessage.toString());
                      
                       
                          if(snapshot.data[index].participants[0].user.id==user.id){
                         
                            participant['name']=snapshot.data[index].participants[1].user.name;
                            participant['img']=snapshot.data[index].participants[1].user.thumbnail;
                            

                            
                          }else{
                            participant['name']=snapshot.data[index].participants[0].user.name;
                            participant['img']=snapshot.data[index].participants[0].user.thumbnail;
         participant['id']=snapshot.data[index].id;                 }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200
                      ),
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (_)=>ChatRoom(participant:participant)));
                                },
                               leading: CircleAvatar(radius: 30,backgroundImage:NetworkImage(participant['img'])),
                                title: Text(participant['name'],style: TextStyle(color: Colors.black),),
                                subtitle: Text(snapshot.data[index].lastMessage.message)
                              ),
                            ),
                          );
                        }),
                   );
                 }
                 else{
                 return CircularProgressIndicator();
                 }
                },
              ),
            );
  }
}
