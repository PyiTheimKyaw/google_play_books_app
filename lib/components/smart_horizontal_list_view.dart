import 'package:flutter/material.dart';

class SmartHorizontalListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;


  SmartHorizontalListView({required this.itemCount,required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: itemBuilder);
  }
}
