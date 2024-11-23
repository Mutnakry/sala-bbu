import 'package:flutter/material.dart';

class PopulorItems extends StatefulWidget {
  const PopulorItems({Key? key}) : super(key: key);

  @override
  State<PopulorItems> createState() => _PopulorItemsState();
}

class _PopulorItemsState extends State<PopulorItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Populor Items'),
      ),
      body: ListView(),
    );
  }
}
