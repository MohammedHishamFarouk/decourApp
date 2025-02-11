import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/search_cubit.dart';
import '../../data/local_data.dart';

class SearchFieldWidget extends StatefulWidget{
  const SearchFieldWidget({super.key});
  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SearchCubit>().searchKey,
      child: TextFormField(
        controller: context.read<SearchCubit>().searchController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none
          ),
          focusColor: Colors.white,
          hintText: 'Search products...',
          hintStyle: TextStyle(
              color:Colors.grey.withOpacity(0.3)
          ),
          suffixIcon:const Icon(Icons.mic,color: Colors.blue,),
        ),
        onChanged: (String value) {context.read<SearchCubit>().listTheItems(LocalData.products);},
      ),
    );
  }
}