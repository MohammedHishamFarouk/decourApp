part of 'items_cubit.dart';

sealed class ItemsState {}

final class ItemsInitial extends ItemsState {}

final class ItemsLoading extends ItemsState {}

final class ItemsSuccess extends ItemsState {
  final List<ItemModel> items;

  ItemsSuccess({required this.items});
}

final class ItemsFailure extends ItemsState {
  final String message;
  ItemsFailure({required this.message});
}
