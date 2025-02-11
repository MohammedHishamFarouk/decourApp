import 'package:bloc/bloc.dart';
import 'package:decourapp/data/core/api/api_consumer.dart';
import 'package:decourapp/data/core/api/end_points.dart';
import 'package:decourapp/data/core/cache/cache_helper.dart';
import 'package:decourapp/data/core/errors/exceptions.dart';
import 'package:decourapp/data/core/functions/upload_image_to_api.dart';
import 'package:decourapp/data/models/get_user_data_model.dart';
import 'package:decourapp/data/models/sign_in_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../data/local_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;

  GlobalKey<FormState> signInFormKey = GlobalKey();

  TextEditingController signInEmail = TextEditingController();

  TextEditingController signInPassword = TextEditingController();

  GlobalKey<FormState> signUpFormKey = GlobalKey();

  TextEditingController signUpEmail = TextEditingController();

  TextEditingController signUpPassword = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  XFile? profilePic;

  bool agreeToTerms = false;

  SignInModel? user;
  signIn() async {
    try {
      if (signInEmail.text.isEmpty || signInPassword.text.isEmpty) {
        emit(SignInFailure(message: 'please fill in the required fields'));
        return;
      }
      emit(SignInLoading());
      final response = await api.post(EndPoints.signIn, data: {
        ApiKey.email: signInEmail.text,
        ApiKey.password: signInPassword.text,
      });
      user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user!.accessToken);
      CacheHelper().saveData(key: ApiKey.accessToken, value: user!.accessToken);
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(message: e.errorModel.message));
    }
  }

  signUp() async {
    try {
      if (signUpPassword.text != confirmPassword.text) {
        emit(SignUpFailure(message: 'please confirm your password'));
        return;
      }
      if (signUpEmail.text.isEmpty ||
          signUpPassword.text.isEmpty ||
          firstName.text.isEmpty ||
          lastName.text.isEmpty) {
        emit(SignUpFailure(message: 'please fill in the required fields'));
        return;
      }
      if (!agreeToTerms) {
        emit(
            SignUpFailure(message: 'please agree to our terms and conditions'));
        return;
      }
      emit(SignUpLoading());
      final response = await api.post(EndPoints.signUP, data: {
        ApiKey.email: signUpEmail.text,
        ApiKey.password: signUpPassword.text,
        ApiKey.name: '${firstName.text} ${lastName.text}',
        ApiKey.avatar: 'https://picsum.photos/800',
      });
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SignUpFailure(message: e.errorModel.message));
    } catch (e) {
      emit(SignUpFailure(message: e.toString()));
    }
  }

  getUserData() async {
    try {
      emit(GetUserLoading());
      final response = await api.get(
        EndPoints.getUser,
      );
      final getUserDataModel = GetUserDataModel.fromJson(response);
      LocalData.userDataModel = getUserDataModel;
      emit(GetUserSuccess());
    } on ServerException catch (e) {
      emit(GetUserFailure(message: e.errorModel.message));
    }
  }

  void checkTermsAndConditions() {
    agreeToTerms = !agreeToTerms;
    emit(TermsState());
  }

  void uploadProfilePic(XFile image) async {
    profilePic = image;
    emit(UploadProfilePicture());
    try {
      final response = await api.put(EndPoints.uploadProfilePic,
          isFormData: true,
          data: {ApiKey.avatar: await uploadImageToApi(image)});
    } on ServerException catch (e) {
      print(e);
    }
  }
}
