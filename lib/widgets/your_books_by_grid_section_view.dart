// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/widgets/book_view_with_book_title_view.dart';

class YourBooksByGridSectionView extends StatelessWidget {
  List<BookVO>? books;
  List<CategoryVO>? category;
  bool isViewMore;

  YourBooksByGridSectionView({required this.books,required this.category,required this.isViewMore});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: category?.length ?? 0,
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/4.5,
      ),
      itemBuilder: (context, index) {
        return  BookViewWithBookTitleView(
          isViewMore: isViewMore,
          books: category?[index].bookDetails?[0],
        );
      },
    );
  }
}
