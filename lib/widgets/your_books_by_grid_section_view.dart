// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/pages/book_details.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/widgets/book_view_with_book_title_view.dart';

class YourBooksByGridSectionView extends StatelessWidget {
  List<BookVO>? books;
  List<CategoryVO>? category;
  bool isViewMore;
  YourBooksByGridSectionView(
      {required this.books, required this.category, this.isViewMore = false,});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: (isViewMore) ? (category?.length ?? 0) : (books?.length ?? 0),
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4.9,
        crossAxisSpacing: 40,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookDetails(
                        book:(isViewMore)? (category?[index].bookDetails?[0]):books?[index],
                        books: (isViewMore)? (category?[index].bookDetails) : books,
                        category: null,
                        bookTitle: "",
                        list: (isViewMore)?(category?[index].listNameEncoded ?? ""):"")));
          },
          child: BookViewWithBookTitleView(
            isViewMore: isViewMore,
            books: (isViewMore)
                ? (category?[index].bookDetails?[0])
                : (books?[index]),
          ),
        );
      },
    );
  }
}
