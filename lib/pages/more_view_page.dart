// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';

class MoreViewPage extends StatelessWidget {
  List<BookVOTest> books;

  MoreViewPage({required this.books});

  _buildTabContext(IndexedWidgetBuilder itemBuilder, int itemCount) =>
      ListView.builder(
        // physics: const ClampingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Top selling books",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Container(),
      ),
    );
  }
}
