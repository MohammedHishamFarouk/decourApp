import 'package:flutter/material.dart';

class TextFormWidget extends StatefulWidget{
  const TextFormWidget({super.key, required this.hintText, required this.hideText, required this.controller});
  final String hintText;
  final bool hideText;
  final TextEditingController controller ;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        focusColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color:Colors.white.withOpacity(0.3)
        ),
        suffixIcon:showSuffixIconButton(),
      ),
      obscureText: widget.hideText?_obscureText:false,
    );
  }

  IconButton? showSuffixIconButton() {
    return widget.hideText? IconButton(onPressed:(){
          setState(() {});
          widget.hideText && _obscureText?
          _obscureText=false:_obscureText = true;
        },
          icon:const Icon(Icons.remove_red_eye_outlined),
        ):null;
  }
}