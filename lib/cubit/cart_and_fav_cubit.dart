import 'package:bloc/bloc.dart';
import 'package:decourapp/view/widgets/cart_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../view/widgets/item_widget.dart';

part 'cart_and_fav_state.dart';

class CartAndFavCubit extends Cubit<CartAndFavState> {
  CartAndFavCubit() : super(CartAndFavInitial());

  List<ItemWidget> favouritesList = [];
  List<int> favItemsId = [];
  List<CartItemWidget> cartItemsList = [];
  List<int> cartItemsId = [];
  List<num> prices = [];

  void addAndRemoveFavourite(ItemWidget item, int id) {
    try {
      if (favouritesList.contains(item)) {
        favouritesList.remove(item);
        favItemsId.remove(id);
      } else {
        favouritesList.add(item);
        favItemsId.add(id);
      }
      emit(CartAndFavSuccess());
    } catch (e) {
      emit(CartAndFavFailure(message: e.toString()));
    }
  }

  bool isItemFav(int id) {
    return favItemsId.contains(id);
  }

  void addToCart(int id, String name, String image, int price, count) {
    if (cartItemsId.contains(id)) {
    } else {
      cartItemsList.add(
        CartItemWidget(
          name: name,
          price: price,
          image: image,
          id: id,
          count: count,
        ),
      );
      cartItemsId.add(id);
    }
    for (int i = 0; i < count; i++) {
      prices.add(price);
    }
    emit(CartAndFavSuccess());
  }

  void deleteFromCart(int id, CartItemWidget cartItem, int price) {
    cartItemsId.remove(id);
    prices.remove(price);
    if (prices.contains(price) == false) {
      cartItemsList.remove(cartItem);
    }

    emit(CartAndFavSuccess());
  }

  num totalPrice() {
    num totalPrice = 0;
    for (var i in prices) {
      totalPrice += i;
    }
    return totalPrice;
  }

  void updateCount() {
    emit(CartAndFavSuccess());
  }
}
