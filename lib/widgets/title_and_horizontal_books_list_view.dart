// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace,
import 'package:flutter/material.dart';
import 'package:google_play_books_app/components/smart_horizontal_list_view.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/categories_label_and_more_view.dart';
import 'package:google_play_books_app/widgets/book_view_with_book_title_view.dart';

class GoogleBooksHorizontalListSectionView extends StatelessWidget {
  final String booksCategoriesLabel;
  final Function(int?, int?) navigateToDetails;
  final bool seePrice;
  int? categoryIndex;
  List<BookVO>? books;
  CategoryVO? category;
  int index;

  GoogleBooksHorizontalListSectionView(
      {required this.booksCategoriesLabel,
      required this.navigateToDetails,
      this.seePrice = true,
      required this.books,
      required this.category,
      required this.categoryIndex,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: CategoriesLabelAndMoreView(
            booksCategoriesLabel: booksCategoriesLabel,
            books: books,
            category: category,
            index: index,
          ),
        ),
        Flexible(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 3.2,
            child: HorizontalBooksListView(
              categoryIndex: categoryIndex,
              book: books,
              seePrice: seePrice,
              navigateToDetails: (categoryIndex, index) {
                navigateToDetails(categoryIndex, index);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class HorizontalBooksListView extends StatelessWidget {
  final Function(int?, int?) navigateToDetails;
  final bool seePrice;
  List<BookVO>? book;
  int? categoryIndex;

  HorizontalBooksListView(
      {required this.navigateToDetails,
      this.seePrice = true,
      required this.book,
      required this.categoryIndex});

  @override
  Widget build(BuildContext context) {
    return SmartHorizontalListView(
      itemCount: book?.length ?? 0,
      // padding: EdgeInsets.only(left: 16),
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.only(right: 12),
          width: 160,
          child: GestureDetector(
            onTap: () {
              navigateToDetails(categoryIndex, index);
            },
            child: BookViewWithBookTitleView(
              seePrice: seePrice,
              books: book?[index],
            ),
          ),
        );
      },
    );
  }
}
