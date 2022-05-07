import 'package:flutter/foundation.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';

class LibraryBloc extends ChangeNotifier {
  String byType = "Author";
  String byView = "List";
  BookModel mBookModel = BookModelImpl();
  List<BookVO>? recentBooks;
  LibraryBloc() {
    mBookModel.getAllRecentBooksFromDatabase().then((books) {
      recentBooks = books;
      notifyListeners();
      recentBooks?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
    });
  }
}
