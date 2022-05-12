import 'package:flutter/foundation.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';

class HomeBloc extends ChangeNotifier{
  ///State variables
  List<CategoryVO>? categoriesList;
  List<BookVO>? bookList;
  BookModel mBookModel=BookModelImpl();
  HomeBloc(){
    mBookModel.getCategoriesListFromDatabase().listen((categoryList) {
      categoriesList=categoryList;
      notifyListeners();
    });
    mBookModel.getAllBooksFromDatabase().listen((event) {
      bookList=event?.where((element) => element.category =="Hardcover Nonfiction").toList();
      // List<BookVO?>? books=event?.map((e) {
      //   print("book Category => ${e.category}");
      // }).toList() ?? [];
      notifyListeners();
    });
  }
}