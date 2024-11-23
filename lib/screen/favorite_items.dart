import 'package:flutter/material.dart';

class FavoriteItems extends StatefulWidget {
  const FavoriteItems({Key? key}) : super(key: key);

  @override
  State<FavoriteItems> createState() => _FavoriteItemsState();
}

class _FavoriteItemsState extends State<FavoriteItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New FavoriteItems'),
      ),
      body: ListView(),
    );
  }
}
