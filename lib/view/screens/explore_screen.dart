import 'package:decourapp/cubit/search_cubit.dart';
import 'package:decourapp/data/local_data.dart';
import 'package:decourapp/view/widgets/search_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        flexibleSpace: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chair_outlined,
                    color: Colors.blue,
                  ),
                  const Spacer(),
                  const Text(
                    'Explore',
                    style: TextStyle(color: Colors.blue, fontSize: 24),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('cart');
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(100),
                  child:const SearchFieldWidget(),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final searchCubit = context.read<SearchCubit>();
          final filteredProducts = searchCubit.listTheItems(LocalData.products);
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return filteredProducts[index];
                  }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio: MediaQuery.of(context).size.width/730),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
