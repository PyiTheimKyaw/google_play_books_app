// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/viewitems/book_item_view.dart';
import 'package:google_play_books_app/viewitems/book_view.dart';

class BookViewWithBookTitleView extends StatelessWidget {
  BookViewWithBookTitleView({this.seePrice=true,required this.books});
  BookVO books;
  final bool seePrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookItemView(booksList: books,),
        SizedBox(
          height: 5,
        ),
        Flexible(
          child: Text(
            books.title,
            style: TextStyle(
                color: TITLE_COLOR,
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        ),
        Visibility(
          visible: seePrice,
          child: Text(
            "\$2.89",
            style: TextStyle(
                color: TITLE_COLOR,
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }


}