import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget{
  const BottomSheetWidget({super.key, required this.price});
  final num price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Total Price',style: TextStyle(fontSize: 24,color: Colors.blue),),
          const Spacer(),
          Text('$price',style:const TextStyle(fontSize: 24,color: Colors.blue),)
        ],
      ),
    );
  }

}