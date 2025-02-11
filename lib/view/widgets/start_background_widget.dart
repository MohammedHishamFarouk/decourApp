import 'dart:ui';
import 'package:flutter/material.dart';

class StartBackGroundWidget extends StatelessWidget{
  const StartBackGroundWidget({super.key, required this.blur});
  final double blur;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Container(
          decoration:const  BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/start_screen_image.jpg'),
                fit: BoxFit.cover
            ),
          ),
        ),
        BackdropFilter(filter: ImageFilter.blur(sigmaX: blur,sigmaY: blur),
          child:  Container(color: Colors.black12),
        )
      ],
    );
  }

}