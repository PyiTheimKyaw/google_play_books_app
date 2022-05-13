// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/more_view_bloc.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/widgets/your_books_by_grid_section_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_large_grid_section_view.dart';
import 'package:provider/provider.dart';

class MoreViewPage extends StatelessWidget {
  String list;
  int index;

  MoreViewPage({
    required this.list,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoreViewBloc>.value(
      value:MoreViewBloc(list, index),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 50,
          titleSpacing: 5,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Consumer<MoreViewBloc>(
            builder: (context, bloc, child) => Text(
              bloc.viewMoreList?[index].listName ?? "",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<MoreViewBloc>(
            builder: (context, bloc, child) =>
                YourBooksByGridSectionView(
              isViewMore: true,
              category: bloc.viewMoreList,
              books: bloc.viewMoreList?[index].books,
            ),
          ),
        ),
      ),
    );
  }
}
