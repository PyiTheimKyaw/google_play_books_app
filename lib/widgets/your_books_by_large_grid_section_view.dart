// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/widgets/book_view_with_book_title_view.dart';

class YourBooksByLargeGridSectionView extends StatelessWidget {
  List<BookVO>? books;

  YourBooksByLargeGridSectionView({required this.books});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: books?.length,
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.45,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL - 5),
          child: BookViewWithBookTitleView(
            books: books?[index],
          ),
        );
      },
    );
  }
}
