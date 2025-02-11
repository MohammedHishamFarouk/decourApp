part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class SignInLoading extends UserState {}
final class SignInSuccess extends UserState {}
final class SignInFailure extends UserState {
  final String message;
  SignInFailure({required this.message});
}

final class UploadProfilePicture extends UserState {}

final class SignUpLoading extends UserState {}
final class SignUpSuccess extends UserState {}
final class SignUpFailure extends UserState {
  final String message;
  SignUpFailure({required this.message});
}

final class TermsState extends UserState{}

final class GetUserLoading extends UserState {}
final class GetUserSuccess extends UserState {}
final class GetUserFailure extends UserState {
  final String message;
  GetUserFailure({required this.message});
}
