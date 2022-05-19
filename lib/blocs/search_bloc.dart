import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';

class SearchBloc extends ChangeNotifier {
  String? query;
  List<BookVO>? allSearchedBooks;
  bool isOnTapSubmitted = false;
  bool isTapClear = false;
  List<String> showSuggestion = [];
  CategoryVO? category;
  Map<String, List<BookVO>?>? dataMap;

  BookModel mBookModel = BookModelImpl();

  SearchBloc([BookModel? bookModel]){
    if(bookModel!=null){
      mBookModel=bookModel;
    }
  }

  void searchBook(String query) {

    mBookModel.getSearchedBooksFromDatabase(query).listen((searchedBooksList) {
      isOnTapSubmitted = false;
      this.query = query;
      allSearchedBooks = searchedBooksList;
      notifyListeners();
    });
  }

  void searchSubmittedBook(String query) {
    mBookModel.getSearchedBooksFromDatabase(query).listen((searchedBooksList) {
      isOnTapSubmitted = true;
      this.query = query;
      allSearchedBooks = searchedBooksList;
      var data = groupBy(
          allSearchedBooks!,
          (BookVO book) =>
              book.searchResults?.volumeInfo?.categories?.first ?? query);
      dataMap = data;
      notifyListeners();
    });
  }
}
