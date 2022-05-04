// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
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
  String query = '';

  List<BookVO> allBokks = dummyBooks;
  List<BookVO> searchedBooks = [];
  bool isOntapChanged = false;
  bool isOnTapSubmitted = false;
  List<String> showSuggestion=[];

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
          searchText: query,
          onChanged: searchBook,
          onTapSubmitted: searchSubmittedBook,
          onTapClear: () {
            setState(() {
              isOnTapSubmitted = false;
              // searchedBooks.remove(searchedBooks);
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
          (query.isNotEmpty)
              ? Expanded(
                  child: (!isOnTapSubmitted)
                      ? ListView.builder(
                          itemCount: searchedBooks.length,
                          itemBuilder: (context, index) {
                            return buildBook(searchedBooks[index]);
                          },
                        )
                      : GoogleBooksHorizontalListSectionView(
                          books: searchedBooks,
                          booksCategoriesLabel: "Shop",
                          navigateToDetails: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetails(
                                        searchedBooks[1],
                                        books: searchedBooks)));
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
    setState(() {
      isOnTapSubmitted = false;
      searchedBooks = allBokks.where((book) {
        final titleLower = book.title.toLowerCase();
        // final authorLower = book.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
        // || authorLower.contains(searchLower);
      }).toList();
      this.query = query;
      allBokks = searchedBooks;
    });
  }

  void searchSubmittedBook(String query) {
    setState(() {
      isOnTapSubmitted = true;
      showSuggestion.add(query);
      searchedBooks = allBokks.where((book) {
        final titleLower = book.title.toLowerCase();
        // final authorLower = book.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
        // || authorLower.contains(searchLower);
      }).toList();
      this.query = query;
      allBokks = searchedBooks;
    });
  }

  Widget buildBook(BookVO book) => ListTile(
        leading: Image.network(
          book.imageUrl ?? "",
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(book.title),
        // subtitle: Text(book.author),
      );
}
