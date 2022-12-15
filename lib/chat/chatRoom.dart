import 'package:flutter/material.dart';
import 'package:lavalpuser/authFile.dart';
import 'package:lavalpuser/main.dart';
import 'package:lavalpuser/model/chatModel.dart';
import 'package:lavalpuser/styles/colors.dart';
import 'package:lavalpuser/styles/fonts.dart';
import 'package:lavalpuser/styles/stylesheet.dart';
import 'package:lavalpuser/xtrawidget/customChatRoomAppbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class ChatRoom extends StatefulWidget {
  final participant;
  const ChatRoom({super.key,this.participant});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   PreferredSize(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(offset: Offset(1,1),color: Color.fromARGB(255, 169, 195, 208),blurRadius: .54,blurStyle: BlurStyle.normal)
          ]),
         child: Padding(
           padding: Styles.pads(4.w, 1.h),
           child: Row(children: [
            CircleAvatar(radius: 25,backgroundImage: NetworkImage(widget.participant['img']),)
            ,Text(widget.participant['name'],style: fonts.h5bold(ColorsData.theme,))
            ,Text(widget.participant['id'].toString(),style: fonts.h5bold(ColorsData.theme,))
            ],),
         ),
        ),
      ),
      preferredSize: Size(100.w, 8.h),
    ),
    body: Column(children: [
      Expanded(child: FutureBuilder(
        initialData: AuthFile().getSingelChat(widget.participant['id'],1)
        ,builder: (context,AsyncSnapshot snapshot){
        return ListView.builder(itemBuilder: (context,int index){
          return Card();
        });
      })),
      Container(height: 8.h,width:100.w,color: Colors.grey.shade200,)
    ],),

    );
  }
}