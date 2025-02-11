import 'package:flutter/material.dart';

class ItemsRowTitle extends StatelessWidget{
  const ItemsRowTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
      child: Row(children: [
        Text(text,style:TextStyle(
            color: Colors.blue[800],
            fontSize: 24
        ),
        ),
        const Spacer(),
        TextButton(onPressed:(){},
          child:Text('SEE ALL',
            style:TextStyle(
                color: Colors.blue[800],
                fontSize: 15
            ),
          ),
        ),
        Icon(Icons.arrow_forward_ios,size: 14,color: Colors.blue[800],)
      ],
      ),
    );
  }

}