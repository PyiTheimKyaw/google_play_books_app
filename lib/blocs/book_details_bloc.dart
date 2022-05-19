import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/pages/book_details.dart';

class BookDetailsBloc extends ChangeNotifier {
  BookModel mBookModel = BookModelImpl();
  OverviewVo? overview;
  List<CategoryVO>? categoriesList;
  List<BookVO>? recentList;
  BookDetailsBloc([BookVO? book,BookModel? bookModel]) {
    if(bookModel!=null){
      mBookModel=bookModel;
    }
    if (book != null) {
      mBookModel.saveSingleBook(book).then((value) {
        print("Book => ${value.toString()}");

        value?.time = DateTime.now();
        recentList?.add(value!);

        mBookModel.saveAllRecentBooks(recentList ?? []);
        notifyListeners();
      });
    }
    mBookModel.getOverview().then((overview) {
      categoriesList = overview?.lists;
      this.overview = overview;
      notifyListeners();
    });
  }
}
