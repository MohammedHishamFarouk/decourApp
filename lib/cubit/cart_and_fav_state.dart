part of 'cart_and_fav_cubit.dart';

@immutable
sealed class CartAndFavState {}

final class CartAndFavInitial extends CartAndFavState {}
final class CartAndFavLoading extends CartAndFavState {}
final class CartAndFavSuccess extends CartAndFavState {}
final class CartAndFavFailure extends CartAndFavState {
  final String message;
  CartAndFavFailure({required this.message});
}


