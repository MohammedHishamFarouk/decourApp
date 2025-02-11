import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignButtonWidget extends StatelessWidget{
  const SignButtonWidget({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton(onPressed: onTap,
        style: FilledButton.styleFrom(
            backgroundColor: Colors.blue,
            shape:const RoundedRectangleBorder()
        ),
        child: Text(text,style:const TextStyle(fontSize: 15),),
      ),
    );
  }

}