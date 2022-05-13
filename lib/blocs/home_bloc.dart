import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/pages/book_details.dart';

class HomeBloc extends ChangeNotifier {
  BookModel mBookModel = BookModelImpl();
  List<CategoryVO>? categoriesList;
  List<BookVO>? recentBooks;
  OverviewVo? overview;
  String? title;
  List<BookVO>? booksList;
  List<BookVO>? allBooks;

  HomeBloc() {
    ///Api call
    mBookModel.getCategoriesListFromDatabase().listen((categoryList) {
      categoriesList = categoryList;
      notifyListeners();
    });
    mBookModel.getAllBooksFromDatabase().listen((event) {
      allBooks = event;
      // List<BookVO?>? books=event?.map((e) {
      //   print("book Category => ${e.category}");
      // }).toList() ?? [];
      notifyListeners();
    });
    mBookModel.getAllRecentBooksFromDatabase().listen((books) {
      recentBooks = books;
      recentBooks?.sort((a, b) =>
          (b.time ?? DateTime.now()).compareTo(a.time ?? DateTime.now()));
      notifyListeners();
    });
  }
}
