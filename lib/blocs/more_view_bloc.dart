import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

class MoreViewBloc extends ChangeNotifier {
  BookModel mBookModel = BookModelImpl();
  List<CategoryVO>? viewMoreList;
  List<CategoryVO>? categoryList;

  OverviewVo? overview;
  List<BookVO>? viewMoreBooks;

  MoreViewBloc(String list, int index) {
    mBookModel.getOverview().then((value) {
      overview = value;
      categoryList = value?.lists;
      notifyListeners();
      mBookModel
          .getBooksList(list, overview?.bestSellersDate ?? "",
              overview?.publishedDate ?? "")
          .then((value) {
        viewMoreList = value;
        viewMoreList?.add(categoryList![index]);
        viewMoreBooks = value?[index].bookDetails;
        notifyListeners();
      }).catchError((error) {
        print("Error ${error.toString()}");
      });
    });
  }
}
