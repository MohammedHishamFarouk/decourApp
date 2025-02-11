import 'dart:ui';

import 'package:decourapp/cubit/cart_and_fav_cubit.dart';
import 'package:decourapp/cubit/items_cubit.dart';
import 'package:decourapp/data/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/items_row_title.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.items,
    required this.id,
  });

  final String image;
  final String title;
  final String description;
  final int price;
  final int id;
  final List<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    int count = 1;
    return Scaffold(
      body: Stack(
        children: [
          Image.network(image),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                Stack(
                  children: [
                    blurContainer(
                      context,
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: blurContainer(
                        context,
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: ClipOval(
                                      child: Divider(
                                        thickness: 5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.blue),
                              ),
                              Text(
                                '$price EGP',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                overflow: TextOverflow.visible,
                                description,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                    width:
                                        MediaQuery.of(context).size.width / 2.4,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.4),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if(count > 1){
                                                count--;
                                                context.read<CartAndFavCubit>().updateCount();
                                              }
                                            },
                                            icon: const Icon(Icons.remove),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        BlocBuilder<CartAndFavCubit,CartAndFavState>(
                                          builder: (context, state) {
                                            return Text(
                                              '$count',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              count++;
                                              context.read<CartAndFavCubit>().updateCount();
                                            },
                                            icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  SizedBox(
                                    height: 70,
                                    width:
                                        MediaQuery.of(context).size.width / 2.4,
                                    child: FilledButton(
                                      onPressed: () {
                                        context.read<CartAndFavCubit>().addToCart(id, title, image, price, count);
                                        context
                                            .read<CartAndFavCubit>()
                                            .totalPrice();
                                      },
                                      style: FilledButton.styleFrom(
                                        shape: const RoundedRectangleBorder(),
                                      ),
                                      child: const Text('add to cart'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                'Reviews(3)',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 30),
                              ),
                              reviews(context, 'Tomas'),
                              reviews(context, 'Penjel'),
                              reviews(context, 'Mohammed'),
                              const ItemsRowTitle(
                                text: 'You May also like',
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: context
                                      .read<ItemsCubit>()
                                      .listTheItems(5, 15, items),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios, size: 22),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('cart'),
                  icon: const Icon(Icons.add_shopping_cart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget blurContainer(BuildContext context, Widget child) {
    return Container(
      decoration: const BoxDecoration(
        backgroundBlendMode: BlendMode.screen,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.white],
            stops: [0.15, 0.4]),
        borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
      ),
      child: child,
    );
  }

  Widget reviews(BuildContext context, String customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          customer,
          style: const TextStyle(color: Colors.blue, fontSize: 16),
        ),
        const Text(
          'Its the best product I have ever seen in my entire life',
          style: TextStyle(color: Colors.grey),
        ),
        const Row(
          children: [
            Expanded(
                child: Divider(
              color: Colors.blue,
            )),
          ],
        ),
      ],
    );
  }
}
