

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lavalpuser/authFile.dart';
import 'package:lavalpuser/main.dart';
import 'package:lavalpuser/model/chatModel.dart';
import 'package:lavalpuser/model/chatRoom.dart';
import 'package:lavalpuser/model/userModel.dart';
import 'package:lavalpuser/styles/colors.dart';
import 'package:lavalpuser/styles/fonts.dart';
import 'package:lavalpuser/styles/stylesheet.dart';
import 'package:lavalpuser/xtrawidget/customChatRoomAppbar.dart';
import 'package:lavalpuser/xtrawidget/customTextField.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../sharedpref/SharedPrefManager.dart';

class ChatRoom extends StatefulWidget {
  final participant;
  const ChatRoom({super.key, this.participant});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late UserModel user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
        getUser();
  }

  Future<void> getUser() async {
    UserModel u = await SharedPrefManager.getUserDataProfile();

    setState(() {
      user = u;
    });
  }
TextEditingController meg=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade200, boxShadow: [
              BoxShadow(
                  offset: Offset(1, 1),
                  color: Color.fromARGB(255, 169, 195, 208),
                  blurRadius: .54,
                  blurStyle: BlurStyle.normal)
            ]),
            child: Padding(
              padding: Styles.pads(4.w, 1.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.participant['img']),
                  ),
                  Text(widget.participant['name'],
                      style: fonts.h5bold(
                        ColorsData.theme,
                      )),
                  Text(widget.participant['id'].toString(),
                      style: fonts.h5bold(
                        ColorsData.theme,
                      ))
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size(100.w, 8.h),
      ),
  body:  FutureBuilder(
                    future:
                        AuthFile().getSingelChatData(widget.participant['id'], 1),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (user.id == snapshot.data[index].userId) {
                                return Container(
                                  width: 80.w,
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text(snapshot.data[index].message),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CircleAvatar(
                                            backgroundImage: NetworkImage(
                                          snapshot.data[index].user.thumbnail,
                                        )),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 100.w,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundImage: NetworkImage(
                                          snapshot.data[index].user.thumbnail,
                                        )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(snapshot.data[index].message
                                                    .toString()),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            });
                      } else {
                        return Text("data");
                      }
                    }),
            
  
      bottomNavigationBar: CustomTextField(),
    );
  }


  getChats(){
    return Scaffold(body: Center(child: Text("LOL"),),
    );}
}
