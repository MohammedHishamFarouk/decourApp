import 'package:decourapp/cubit/cart_and_fav_cubit.dart';
import 'package:decourapp/data/models/item_model.dart';
import 'package:decourapp/view/screens/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.items,
    required this.id,
  });

  final String title;
  final String description;
  final int price;
  final List<String> image;
  final List<ItemModel> items;
  final int id;

  @override
  bool operator ==(Object other){
    return identical(this,other)||(other is ItemWidget && id == other.id);
  }

  @override
  int get hashcode => id.hashCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                GestureDetector(
                  onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ItemScreen(
                          image: image[0],
                          title: title,
                          description: description,
                          price: price,
                          items: items,
                          id: id,
                        );
                      },
                    ),
                  );
                    },
                  child: SizedBox(
                    height: 125,
                    width: 100,
                    child: Image.network(
                      image[0],
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        if (image.length == 2) {
                          return Image.network(image[1]);
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                  ),
                ),
                BlocBuilder<CartAndFavCubit, CartAndFavState>(
                  builder: (context, state) {
                    return IconButton(
                      hoverColor: Colors.transparent,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(4),
                      onPressed: () {
                        context.read<CartAndFavCubit>().addAndRemoveFavourite(this,id);
                      },
                      icon: context.read<CartAndFavCubit>().isItemFav(id)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_outline),
                      color: Colors.blue,
                      iconSize: 20,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              width: 100,
              child: Text(
                overflow: TextOverflow.visible,
                title,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                ),
              ),
            ),
            Text(
              "$price EGP",
              style: const TextStyle(
                overflow: TextOverflow.visible,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
