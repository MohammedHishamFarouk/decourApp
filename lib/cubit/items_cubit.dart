import 'package:bloc/bloc.dart';
import 'package:decourapp/data/core/api/api_consumer.dart';
import 'package:decourapp/data/core/api/end_points.dart';
import 'package:decourapp/data/core/errors/exceptions.dart';
import 'package:decourapp/data/local_data.dart';
import 'package:decourapp/data/models/item_model.dart';
import 'package:decourapp/data/models/items_list_model.dart';
import 'package:flutter/material.dart';

import '../view/widgets/item_widget.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit(this.api) : super(ItemsInitial());
  final ApiConsumer api;

  getItemsList()async{
    try{
      emit(ItemsLoading());
      final response = await api.get(
        EndPoints.getItems,
      );
      final getItemsModel = ItemsListModel.fromJson(response);
      final List<ItemModel> items = getItemsModel.itemsList.map((e) => ItemModel.fromJson(e)).toList();
      LocalData.products.addAll(items);
      emit(ItemsSuccess(items: items));
    }on ServerException catch(e){
      emit(ItemsFailure(message: e.errorModel.message));
    }
  }

  List<Widget> listTheItems (int start,int finish,List<ItemModel>items){
    List<Widget> products = [];
    for(int i = start;i < finish;i++){
      products.add(Padding(
        padding: const EdgeInsets.only(left: 8),
        child:ItemWidget(
          title:items[i].title,
          price: items[i].price,
          image: items[i].images,
          description: items[i].description,
          id: items[i].id,
          items: items,
        ),
      )
      );
    }
    return products;
  }

}

