import 'package:decourapp/cubit/cart_and_fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_sheet_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Your Cart'),
      ),
      body: BlocBuilder<CartAndFavCubit, CartAndFavState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: context.read<CartAndFavCubit>().cartItemsList,
            ),
          );
        },
      ),
      bottomSheet: BlocBuilder<CartAndFavCubit, CartAndFavState>(
        builder: (context, state) {
          return BottomSheetWidget(
              price: context.read<CartAndFavCubit>().totalPrice());
        },
      ),
    );
  }
}
