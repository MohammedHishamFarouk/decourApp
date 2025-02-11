import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../data/models/item_model.dart';
import '../view/widgets/item_widget.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  TextEditingController searchController = TextEditingController();

  GlobalKey<FormState> searchKey = GlobalKey();
  Set<int> itemId = {};

  List<Widget> listTheItems (List<ItemModel>items){
    List<Widget> products = [];
    products.clear();
    itemId.clear();
    if(searchController.text.isEmpty){
      for(var i in items){
        if(!itemId.contains(i.id)){
          itemId.add(i.id);
          products.add(Padding(
            padding: const EdgeInsets.only(left: 8),
            child:ItemWidget(
              title: i.title,
              price: i.price,
              image: i.images,
              description: i.description,
              id: i.id,
              items: items,
            ),
          )
          );
        }
      }
    }else{
      String query = searchController.text.toLowerCase();
      for(var item in items){
          if(!itemId.contains(item.id)){
            if(item.title.toLowerCase().contains(query)){
              itemId.add(item.id);
              products.add(Padding(
                padding: const EdgeInsets.only(left: 8),
                child:ItemWidget(
                  title:item.title,
                  price: item.price,
                  image: item.images,
                  description: item.description,
                  id: item.id,
                  items: items,
                ),
              ),
              );
            }
        }
      }
    }
    emit(SearchSuccess());
    return products;
  }

}
