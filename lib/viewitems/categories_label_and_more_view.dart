// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/pages/more_view_page.dart';
import 'package:google_play_books_app/resources/dimens.dart';

class CategoriesLabelAndMoreView extends StatelessWidget {
  // List<BookVO>? books;
  CategoryVO? category;
  final String booksCategoriesLabel;
  int index;

  CategoriesLabelAndMoreView(
      {required this.category,required this.booksCategoriesLabel,required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: Text(
            booksCategoriesLabel,
            style: TextStyle(
                fontSize: TEXT_REGULAR_2, fontWeight: FontWeight.w600),
          ),
        ),
        Spacer(),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoreViewPage(
                    index: index,
                    list: category?.listNameEncoded ?? "",
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_forward_outlined,
              size: MARGIN_MEDIUM_3,
              color: Colors.blue,
            ))
      ],
    );
  }
}
