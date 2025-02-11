import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'scroll_state.dart';

class ScrollCubit extends Cubit<ScrollState> {
  ScrollCubit(this.scrollController, this.context) : super(ScrollInitial());
  final ScrollController scrollController;
  Timer? _timer;
  final BuildContext context;

  void startAutoScroll(){
    _timer = Timer.periodic(const Duration(seconds: 3), (timer){
      if(scrollController.hasClients){
        double newScrollPosition = scrollController.position.pixels + MediaQuery.of(context).size.width;
        if(newScrollPosition > scrollController.position.maxScrollExtent){
          newScrollPosition = 0;
        }
        scrollController.animateTo(
            newScrollPosition,
            duration:const Duration(milliseconds: 1200),
            curve: Curves.easeInOut,
        );
        emit(ScrollStateActive());
      }
    },
    );
  }

  void stopAutoScroll(){
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close(){
    stopAutoScroll();
    return super.close();
  }

}
