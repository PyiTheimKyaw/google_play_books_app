// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace,
import 'package:flutter/material.dart';
import 'package:google_play_books_app/components/smart_horizontal_list_view.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/viewitems/categories_label_and_more_view.dart';
import 'package:google_play_books_app/widgets/book_view_with_book_title_view.dart';

class GoogleBooksHorizontalListSectionView extends StatelessWidget {
  final String booksCategoriesLabel;
  final Function navigateToDetails;
  final bool seePrice;
  List<BookVO> books;
  GoogleBooksHorizontalListSectionView(
      {required this.booksCategoriesLabel, required this.navigateToDetails,this.seePrice=true,required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: CategoriesLabelAndMoreView(booksCategoriesLabel: booksCategoriesLabel,books: books,),
        ),
        Flexible(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 3.2,
            child: HorizontalBooksListView(
              book: books,
              seePrice: seePrice,
              navigateToDetails: () {
                navigateToDetails();
              },
            ),
          ),
        ),
      ],
    );
  }
}



class HorizontalBooksListView extends StatelessWidget {
  final Function navigateToDetails;
  final bool seePrice;
  List<BookVO> book;
  HorizontalBooksListView({required this.navigateToDetails,this.seePrice=true,required this.book});

  @override
  Widget build(BuildContext context) {
    return SmartHorizontalListView(
      itemCount: 9,
      // padding: EdgeInsets.only(left: 16),
      itemBuilder: (_, index) {
        return Container(
          margin: EdgeInsets.only(right: 12),
          width: 170,
          child: GestureDetector(
            onTap: () {
              navigateToDetails();
            },
            child: BookViewWithBookTitleView(seePrice: seePrice,books: book[index],),
          ),
        );
      },
    );
  }
}


