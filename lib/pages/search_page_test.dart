import 'dart:math';

import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flappy_search_bar_ns/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/pages/library_page.dart';
import 'package:google_play_books_app/viewitems/book_and_row_title_view.dart';
import 'package:google_play_books_app/widgets/your_books_by_list_section_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SearchBarController<BookVO> _searchBarController =
      SearchBarController();
  bool isReplay = false;

  Future<List<BookVO>> _getALlPosts(String? text) async {
    await Future.delayed(Duration(seconds: text!.length == 4 ? 10 : 1));
    if (isReplay)
      return [
        BookVO(
          "The Marathon Don't stop !",
        )
      ];
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<BookVO> books = [];

    var random = new Random();
    for (int i = 0; i < 10; i++) {
      books.add(
        BookVO("$text $i"),
      );
    }
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<BookVO>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          searchBarController: _searchBarController,
          onError: (error) => Text('ERROR: ${error.toString()}'),
          // placeHolder: Text("placeholder"),
          hintText: "Search Play Books",
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) =>
              ScaledTile.count(1, index.isEven ? 2 : 1),

          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          // crossAxisSpacing: 10,
          crossAxisCount: 1,
          onItemFound: (BookVO? post, int index) {
            return BookAAndTitleRowView();
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
