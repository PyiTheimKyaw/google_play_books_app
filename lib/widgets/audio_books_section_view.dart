import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';

class AudioBooksSectionView extends StatelessWidget {
  final List<BookVO>? booksList;
  final Function(int?, int?) navigatePage;
  List<CategoryVO>? category;

  AudioBooksSectionView(
      {required this.booksList,
      required this.navigatePage,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: booksList?.length,
        itemBuilder: (context, index) {
          return GoogleBooksHorizontalListSectionView(
            index: index,
            category: category?[index],
            categoryIndex: index,
            books: booksList,
            navigateToDetails: (index, title) {
              navigatePage(index, title);
            },
            booksCategoriesLabel: "Tales of terror & intrigue",
          );
        });
  }
}
