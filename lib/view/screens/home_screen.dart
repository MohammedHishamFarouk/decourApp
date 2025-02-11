import 'package:decourapp/cubit/items_cubit.dart';
import 'package:decourapp/cubit/scroll_cubit.dart';
import 'package:decourapp/view/widgets/appbar_image_widget.dart';
import 'package:decourapp/view/widgets/items_row_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    context.read<ItemsCubit>().getItemsList();
    return BlocConsumer<ItemsCubit, ItemsState>(
      listener: (context, state) {
        if (state is ItemsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is ItemsInitial) {}
      },
      builder: (context, state) {
        return BlocProvider(
          create: (context) =>
              ScrollCubit(_controller, context)..startAutoScroll(),
          child: Scaffold(
            drawer: const Drawer(),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverLayoutBuilder(builder:
                    (BuildContext context, SliverConstraints constraints) {
                  final scrolled = constraints.scrollOffset > 100;
                  return SliverAppBar(
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    backgroundColor:
                        scrolled ? Colors.blue : Colors.transparent,
                    expandedHeight: 450,
                    title: const Text(
                      'Douceur Homewear',
                      style: TextStyle(color: Colors.white),
                    ),
                    pinned: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('cart');
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: BlocBuilder<ScrollCubit, ScrollState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 3,
                                  controller: _controller,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return const Row(
                                      children: [
                                        AppBarImageWidget(
                                          image: 'assets/bedroom_side.jpg',
                                        ),
                                        AppBarImageWidget(
                                          image: 'assets/livingRoom.jpg',
                                        ),
                                        AppBarImageWidget(
                                          image: 'assets/livingRoom2.jpg',
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }),
                const SliverToBoxAdapter(
                  child: ItemsRowTitle(
                    text: 'Bestseller',
                  ),
                ),
                SliverToBoxAdapter(
                  child: state is ItemsSuccess
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: state.items.length >= 10
                              ? Row(
                                  children: context
                                      .read<ItemsCubit>()
                                      .listTheItems(0, 10, state.items),
                                )
                              : const SizedBox(),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
                const SliverToBoxAdapter(
                  child: ItemsRowTitle(
                    text: 'SummerDeals',
                  ),
                ),
                SliverToBoxAdapter(
                  child: state is ItemsSuccess
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: state.items.length >= 20
                              ? Row(
                                  children: context
                                      .read<ItemsCubit>()
                                      .listTheItems(10, 20, state.items),
                                )
                              : const SizedBox(),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
                const SliverToBoxAdapter(
                  child: ItemsRowTitle(
                    text: 'Popular',
                  ),
                ),
                SliverToBoxAdapter(
                  child: state is ItemsSuccess
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: state.items.length >= 30
                              ? Row(
                                  children: context
                                      .read<ItemsCubit>()
                                      .listTheItems(20, 30, state.items))
                              : const SizedBox(),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
