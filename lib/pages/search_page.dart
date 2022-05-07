// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo_test.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/dummy/dummy_data.dart';
import 'package:google_play_books_app/pages/book_details.dart';
import 'package:google_play_books_app/resources/colors.dart';
import 'package:google_play_books_app/resources/dimens.dart';
import 'package:google_play_books_app/widgets/searh_widget.dart';
import 'package:google_play_books_app/widgets/title_and_horizontal_books_list_view.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? query;

  List<BookVO>? allSearchedBooks;

  List<BookVO>? searchedBooks = [];
  bool isOntapChanged = false;
  bool isOnTapSubmitted = false;
  bool isTapClear = false;
  List<String> showSuggestion = [];
  CategoryVO? category;

  BookModel mBookModel = BookModelImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: MARGIN_SMALL - 7,
        backgroundColor: Colors.white,
        elevation: 0.2,
        iconTheme: IconThemeData(color: ICON_COLOR),
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: SearchWidget(
          searchText: query ?? "",
          onChanged: searchBook,
          onTapSubmitted: searchSubmittedBook,
          onTapClear: () {
            setState(() {
              isOnTapSubmitted = false;
              isTapClear = true;
              query = null;
            });
          },
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
          (query?.isNotEmpty ?? false)
              ? Expanded(
                  child: (!isOnTapSubmitted)
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: allSearchedBooks?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: buildBook(allSearchedBooks?[index]),
                            );
                          },
                        )
                      : GoogleBooksHorizontalListSectionView(
                          index: 1,
                          category: category,
                          books: searchedBooks,
                          booksCategoriesLabel: "Shop",
                          categoryIndex: 0,
                          navigateToDetails: (i, j) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetails(
                                  book: searchedBooks?[1],
                                  books: searchedBooks,
                                  bookTitle: "",
                                  category: [],
                                  list: "",
                                ),
                              ),
                            );
                          },
                        ),
                )
              : Row(
                  children: [
                    Icon(Icons.timelapse),
                    Text(showSuggestion.reversed.take(4).toString()),
                  ],
                ),
        ],
      ),
    );
  }

  void searchBook(String query) {
    mBookModel.getSearchBooks(query).then((searchedBooksList) {
      setState(() {
        isOnTapSubmitted = false;
        this.query = query;
        allSearchedBooks = searchedBooksList;
      });
    });
    // setState(() {
    //   isOnTapSubmitted = false;
    //   searchedBooks = allBokks?.where((book) {
    //     final titleLower = book.title?.toLowerCase();
    //     // final authorLower = book.author.toLowerCase();
    //     final searchLower = query.toLowerCase();
    //
    //     return titleLower?.contains(searchLower) ?? false;
    //     // || authorLower.contains(searchLower);
    //   }).toList();
    //   this.query = query;
    //   allBokks = searchedBooks;
    // });
  }

  void searchSubmittedBook(String query) {
    setState(() {
      isOnTapSubmitted = true;
      showSuggestion.add(query);
      searchedBooks = allSearchedBooks?.where((book) {
        final titleLower = book.title?.toLowerCase();
        // final authorLower = book.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower?.contains(searchLower) ?? false;
        // || authorLower.contains(searchLower);
      }).toList();
      this.query = query;
      allSearchedBooks = searchedBooks;
    });
  }

  Widget buildBook(BookVO? book) => ListTile(
        horizontalTitleGap: 20,

        leading: Image.network(
          book?.bookImage ?? "",
          fit: BoxFit.cover,
          width: 70,
          height: 70,
        ),
        title: Text(book?.title ?? ""),
        // subtitle: Text(book.author),
      );
}
