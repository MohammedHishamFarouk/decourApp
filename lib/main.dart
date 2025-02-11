import 'package:decourapp/cubit/cart_and_fav_cubit.dart';
import 'package:decourapp/cubit/items_cubit.dart';
import 'package:decourapp/cubit/search_cubit.dart';
import 'package:decourapp/cubit/user_cubit.dart';
import 'package:decourapp/data/core/api/dio_consumer.dart';
import 'package:decourapp/data/core/cache/cache_helper.dart';
import 'package:decourapp/view/screens/cart_screen.dart';
import 'package:decourapp/view/screens/home_screen.dart';
import 'package:decourapp/view/screens/loading_screen.dart';
import 'package:decourapp/view/screens/navigationbar_screen.dart';
import 'package:decourapp/view/screens/signIn_screen.dart';
import 'package:decourapp/view/screens/signUp_screen.dart';
import 'package:decourapp/view/screens/start_screen.dart';
import 'package:decourapp/view/styles/theme_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              UserCubit(DioConsumer(dio: Dio()))..getUserData()),
      BlocProvider(create: (context) => ItemsCubit(DioConsumer(dio: Dio()))),
      BlocProvider(create: (context) => CartAndFavCubit()),
      BlocProvider(create: (context) => SearchCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getThemeData(),
      initialRoute: 'Navigation',
      routes: {
        'start': (context) => const StartScreen(),
        'signIn': (context) => const SignInScreen(),
        'signUp': (context) => const SignUpScreen(),
        'Home': (context) => const HomeScreen(),
        'loading': (context) => const LoadingScreen(),
        'Navigation': (context) => const NavigationBarScreen(),
        'cart': (context) => const CartScreen(),
      },
    );
  }
}
