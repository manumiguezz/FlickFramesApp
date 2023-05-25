

import 'package:app_cinema/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FavouriteViewState();
}

class FavouriteViewState extends ConsumerState <FavouritesView> {
  
  @override
  void initState() {
    super.initState();
    ref.read(favouriteMoviesProvider.notifier).loadNextPage();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('data'),
          );
        },
      )
    );

  }

}


  