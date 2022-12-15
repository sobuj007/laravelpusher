import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomChatRoomAppbar extends StatelessWidget {
  final thum;
  final name;
  

  const CustomChatRoomAppbar({super.key,this.name,this.thum});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(),
      preferredSize: Size(100.w, 8.h),
    );
  }
}