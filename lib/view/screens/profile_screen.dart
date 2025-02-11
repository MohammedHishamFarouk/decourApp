import 'dart:io';

import 'package:decourapp/cubit/user_cubit.dart';
import 'package:decourapp/data/core/cache/cache_helper.dart';
import 'package:decourapp/data/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {},
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  ImagePicker().pickImage(source: ImageSource.gallery).then(
                        (value) =>
                            context.read<UserCubit>().uploadProfilePic(value!),
                      );
                },
                child: context.read<UserCubit>().profilePic == null
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/defaultAvatar.png'),
                        radius: 150,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(
                          File(context.read<UserCubit>().profilePic!.path),
                        ),
                        radius: 150,
                      ),
              );
            },
          ),
          const SizedBox(
            height: 175,
          ),
          Text(LocalData.userDataModel!.name,
              style: const TextStyle(color: Colors.blue, fontSize: 24)),
          const SizedBox(height: 10),
          Text(
            LocalData.userDataModel!.email,
            style: const TextStyle(color: Colors.blue, fontSize: 24),
          ),
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            height: 70,
            width: MediaQuery.of(context).size.width /
                2.4,
            child: FilledButton(
              onPressed: () {
                CacheHelper.sharedPreferences.clear();
                Navigator.of(context).pushReplacementNamed('start');
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: const RoundedRectangleBorder(),
              ),
              child: const Text('Log out'),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
