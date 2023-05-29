

import 'package:flutter/material.dart';


class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const Scaffold(
      body: Text('categories'),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}