import 'package:decourapp/cubit/cart_and_fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget(
      {super.key, required this.name, required this.price, required this.image, required this.id, required this.count});

  final String name;
  final int price;
  final String image;
  final int id;
  int count;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CartItemWidget && id == other.id);
  }

  int get hashcode => id.hashCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: ListTile(
          title: BlocBuilder<CartAndFavCubit, CartAndFavState>(
            builder: (context, state) {
              return Text("$name  |item count:($count)");
            },
          ),
          subtitle: Text('$price'),
          trailing: IconButton(onPressed: () {
            context.read<CartAndFavCubit>().deleteFromCart(id, this, price);
            context.read<CartAndFavCubit>().totalPrice();
            count--;
          }, icon: const Icon(Icons.remove_circle_outline)),
          leading: Image.network(image),
        ),
      ),
    );
  }

}