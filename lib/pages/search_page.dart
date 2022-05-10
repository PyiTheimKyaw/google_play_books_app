// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/blocs/search_bloc.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/google_book_vo.dart';
import 'package:google_play_books_app/data/vos/google_search_vo.dart';
import 'package:google_play_books_app/dummy/dummy_data.dart';
import 'package:google_play_books_app/pages/book_details.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/widgets/searh_widget.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: MARGIN_SMALL - 7,
          backgroundColor: Colors.white,
          elevation: 0.2,
          iconTheme: IconThemeData(color: ICON_COLOR),
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          title: Consumer<SearchBloc>(
            builder: (context, bloc, child) => SearchWidget(
              searchText: bloc.query ?? "",
              onChanged: bloc.searchBook,
              onTapSubmitted: bloc.searchSubmittedBook,
              onTapClear: () {
                bloc.isOnTapSubmitted = false;
                bloc.isTapClear = true;
                bloc.query = null;
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
              child: Icon(
                Icons.mic,
                color: ICON_COLOR,
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Consumer<SearchBloc>(
              builder: (context, bloc, child) => (bloc.query?.isNotEmpty ??
                  false)
                  ? Expanded(
                child: (!bloc.isOnTapSubmitted)
                    ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: bloc.allSearchedBooks?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0),
                      child:
                      buildBook(bloc.allSearchedBooks?[index],context),
                    );
                  },
                )
                    : ListView.builder(
                  itemCount: bloc.dataMap?.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GoogleBooksHorizontalListSectionView(
                      index: 1,
                      category: bloc.category,
                      books: bloc.dataMap?.values.elementAt(index),
                      booksCategoriesLabel:
                      bloc.dataMap?.keys.elementAt(index) ?? "",
                      categoryIndex: 0,
                      navigateToDetails: (i, j) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetails(
                              book: bloc.dataMap?.values
                                  .elementAt(index)?[j!],
                              books: bloc.dataMap?.values
                                  .elementAt(index),
                              bookTitle: "",
                              category: [],
                              list: "",
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
                  : Row(
                children: [
                  Icon(Icons.timelapse),
                  // Text(showSuggestion.reversed.take(4).toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget buildBook(BookVO? book,BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookDetails(
                  book: book,
                  books: [],
                  category: [],
                  bookTitle: "",
                  list: "")));
    },
    child: ListTile(
      horizontalTitleGap: 20,

      leading: Image.network(
        book?.bookImage ?? "",
        fit: BoxFit.fill,
        width: 70,
        height: 70,
      ),
      title: Text(book?.title ?? ""),
      // subtitle: Text(book.author),
    ),
  );
}


