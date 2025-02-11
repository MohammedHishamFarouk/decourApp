import 'package:decourapp/view/screens/explore_screen.dart';
import 'package:decourapp/view/screens/favourites_screen.dart';
import 'package:decourapp/view/screens/home_screen.dart';
import 'package:decourapp/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {

  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const FavouritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {_selectedIndex = value;});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favourites'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile'
          ),
        ],
      ),
    );
  }
}
