import 'package:decourapp/cubit/user_cubit.dart';
import 'package:decourapp/view/widgets/other_signin_options.dart';
import 'package:decourapp/view/widgets/sign_button_widget.dart';
import 'package:decourapp/view/widgets/start_background_widget.dart';
import 'package:decourapp/view/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('success'),
            ),
          );
          context.read<UserCubit>().getUserData();
          Navigator.of(context).pushNamedAndRemoveUntil('Navigation',(Route<dynamic> route) => false);
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              const StartBackGroundWidget(blur: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height:30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 16),
                            child: IconButton(
                                onPressed: () => Navigator.of(context).pushReplacementNamed('start'),
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_sharp,
                                  size: 22,
                                  color: Colors.white,
                                )),
                          ),
                          pageText('Sign In', 38),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 57),
                          pageText('Welcome Back,Continue your adventure', 12),
                        ],
                      ),
                      const SizedBox(height: 75),
                      Form(
                        key: context.read<UserCubit>().signInFormKey,
                        child: Column(
                          children: [
                            TextFormWidget(
                              hintText: 'Email',
                              hideText: false,
                              controller: context.read<UserCubit>().signInEmail,
                            ),
                            const SizedBox(height: 30),
                            TextFormWidget(
                              hintText: 'password',
                              hideText: true,
                              controller: context.read<UserCubit>().signInPassword,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 76,),
                      state is SignInLoading
                          ? const CircularProgressIndicator()
                          : SignButtonWidget(
                              text: 'Sign In',
                              onTap: () {
                                context.read<UserCubit>().signIn();
                              }),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {},
                        child: pageText('Forgot password?', 15),
                      ),
                      const SizedBox(height: 55),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 47.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(child: Divider(color: Colors.white)),
                            const SizedBox(width: 14),
                            pageText('or sign in with', 16),
                            const SizedBox(width: 14),
                            const Expanded(
                                child: Divider(
                              color: Colors.white,
                            )),
                          ],
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OtherSignInOptions(
                            image: 'assets/Google.png',
                            size: 40,
                          ),
                          OtherSignInOptions(
                            image: 'assets/facebook.png',
                            size: 55,
                          ),
                          OtherSignInOptions(
                            image: 'assets/apple_ios.png',
                            size: 50,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            pageText("Don't have an account yet?", 14),
                            TextButton(
                              onPressed: ()=> Navigator.of(context).pushReplacementNamed('signUp'),
                              child: pageText('Sign up', 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Text pageText(String text, double size) {
    return Text(
      maxLines: 2,
      text,
      style: TextStyle(fontSize: size),
    );
  }
}
