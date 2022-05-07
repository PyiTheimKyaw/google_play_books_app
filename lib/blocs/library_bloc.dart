import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';

class LibraryBloc extends ChangeNotifier {
  String byType = "Author";

  String byView = "List";
  BookModel mBookModel = BookModelImpl();
  List<BookVO>? recentBooks;

  LibraryBloc() {
    mBookModel.getAllRecentBooksFromDatabase().listen((books) {
      recentBooks = books;
      notifyListeners();
      recentBooks?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
    });
  }

  void sortByType(String? type, BuildContext context) {
    if (type != null) {
      byType = type;
      if (byType == "Author") {
        recentBooks?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
      } else if (byType == "Title") {
        recentBooks?.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
      } else {
        recentBooks?.sort((a, b) =>
            (b.time ?? DateTime.now()).compareTo(a.time ?? DateTime.now()));
      }
      Navigator.pop(context);
      notifyListeners();
    }
  }

  void sortByView(String? view, BuildContext context) {
    if (view != null) {
      byView = view;
      Navigator.pop(context);
      notifyListeners();
    }
  }
}
