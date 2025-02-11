import 'package:decourapp/view/widgets/sign_button_widget.dart';
import 'package:decourapp/view/widgets/start_background_widget.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          const StartBackGroundWidget(blur: 0),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  textTitle('Douceur Homewear',40,1),
                  textTitle('where Elegance Resides,  and Beauty Blossoms',15,0),
                  const Spacer(flex: 4),
                  SignButtonWidget(text: 'Sign In', onTap: () =>
                      Navigator.of(context).pushNamed('signIn'),
                  ),
                  const SizedBox(height: 15),
                  SignButtonWidget(text: 'Sign Up', onTap: () =>
                      Navigator.of(context).pushNamed('signUp'),),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox textTitle(String text,double fontSize,double height) {
    return SizedBox(width: 200,
      child: Text(text,
        style: TextStyle(
            fontSize: fontSize,height: height),),);
  }
}
