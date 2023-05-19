import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {

  final int currentIndex; 

  const CustomBottomNavigation({
    super.key, 
    required this.currentIndex
  });

  void onItemTapped(BuildContext context, int index){
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      elevation: 5,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',       
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