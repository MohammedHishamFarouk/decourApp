import 'package:decourapp/cubit/user_cubit.dart';
import 'package:decourapp/view/widgets/sign_button_widget.dart';
import 'package:decourapp/view/widgets/start_background_widget.dart';
import 'package:decourapp/view/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('success'),
            ),
          );
          context.read<UserCubit>().getUserData();
          Navigator.of(context).pushReplacementNamed('signIn');
        } else if (state is SignUpFailure) {
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
                      const SizedBox(height: 18),
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
                          pageText('Sign Up', 38),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 57),
                          pageText(
                              'Create an account to start your exploration', 12),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: context.read<UserCubit>().signUpFormKey,
                        child: Column(
                          children: [
                            TextFormWidget(
                              hintText: 'First Name*',
                              hideText: false,
                              controller: context.read<UserCubit>().firstName,
                            ),
                            const SizedBox(height: 20),
                            TextFormWidget(
                              hintText: 'Last Name*',
                              hideText: false,
                              controller: context.read<UserCubit>().lastName,
                            ),
                            const SizedBox(height: 20),
                            TextFormWidget(
                              hintText: 'Email*',
                              hideText: false,
                              controller: context.read<UserCubit>().signUpEmail,
                            ),
                            const SizedBox(height: 20),
                            TextFormWidget(
                              hintText: 'Password*',
                              hideText: true,
                              controller: context.read<UserCubit>().signUpPassword,
                            ),
                            const SizedBox(height: 20),
                            TextFormWidget(
                              hintText: 'Confirm Password',
                              hideText: true,
                              controller: context.read<UserCubit>().confirmPassword,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          BlocBuilder<UserCubit, UserState>(
                            builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                              context.read<UserCubit>().checkTermsAndConditions();
                              },
                              icon: context.read<UserCubit>().agreeToTerms
                                ? const Icon(Icons.check_box_sharp)
                                : const Icon(Icons.check_box_outline_blank_sharp),
                            color: Colors.white,
                            iconSize: 34,
                          );
                            },
                          ),
                          pageText('Agree to terms and conditions', 14.6)
                        ],
                      ),
                      const SizedBox(height: 35,),
                      state is SignUpLoading
                          ? const CircularProgressIndicator()
                          : SignButtonWidget(
                              text: 'Sign Up',
                              onTap: () {
                                context.read<UserCubit>().signUp();
                              }),
                      const SizedBox(height: 35,),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            pageText("Already have an account?", 14),
                            TextButton(
                              onPressed: ()=>Navigator.of(context).pushReplacementNamed('signIn'),
                              child: pageText('Sign In', 14),
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
      text,
      style: TextStyle(fontSize: size),
    );
  }
}
