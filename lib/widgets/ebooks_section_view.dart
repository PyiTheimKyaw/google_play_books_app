import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';

class EbooksSectionView extends StatelessWidget {
  final Function(int?, int?) navigatePage;
  List<CategoryVO>? category;


  EbooksSectionView(
      {required this.navigatePage, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: category?.length ?? 0,
        itemBuilder: (context, index) {
          return GoogleBooksHorizontalListSectionView(
            index: index,
            books: category?[index].books,
            category: category?[index],
            categoryIndex: index,
            navigateToDetails: (index, title) {
              navigatePage(index, title);
            },
            booksCategoriesLabel: category?[index].listName ?? "",
          );
        });
  }
}
