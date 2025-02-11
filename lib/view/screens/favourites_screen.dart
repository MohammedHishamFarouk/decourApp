import 'package:decourapp/cubit/cart_and_fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocBuilder<CartAndFavCubit, CartAndFavState>(
                  builder: (context, state) {
                    return Wrap(
                      children: context
                          .read<CartAndFavCubit>()
                          .favouritesList,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}