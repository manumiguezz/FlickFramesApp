import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 5,
      items: const [
        
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.movie_filter_outlined),
          label: 'Categories'
        ),
        
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border_outlined),
          label: 'Favourites'
        ),
      ]
    );
  }
}