import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController msg=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 10.h,
       child: Padding(
         padding: const EdgeInsets.all(4.0),
         child: TextField(

controller: msg,
  style: TextStyle(fontSize: 20),
  maxLines: 2,
),
       ),
    );
  }
}