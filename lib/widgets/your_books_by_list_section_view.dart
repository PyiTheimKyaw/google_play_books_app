// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/book_and_row_title_view.dart';
import 'package:google_play_books_app/viewitems/more_button_view.dart';

class YourBooksByListSectionView extends StatelessWidget {
  List<BookVO>? bookList;

  YourBooksByListSectionView({required this.bookList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            BookTitleAndActionsSectionView(
              bookList: bookList,
              index: index,
            ),
          ],
        );
      },
    );
  }
}

class BookTitleAndActionsSectionView extends StatelessWidget {
  const BookTitleAndActionsSectionView({
    Key? key,
    required this.bookList,
    required this.index,
  }) : super(key: key);

  final List<BookVO>? bookList;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,s
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: BookAAndTitleRowView(
            book: bookList?[index],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Icon(
                Icons.download_outlined,
                color: ICON_COLOR,
              ),
              SizedBox(
                width: 12,
              ),
              MoreButtonView(
                isLibrary: true,
                book: bookList?[index],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
