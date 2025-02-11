import 'package:flutter/material.dart';

class OtherSignInOptions extends StatelessWidget{
  const OtherSignInOptions({super.key, required this.image, required this.size});
  final String image;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
      child: GestureDetector(
        child:Image(
          color: Colors.blue,
          height:size,
          width:size,
          image: AssetImage(image),
        ),
      ),
    );
  }

}