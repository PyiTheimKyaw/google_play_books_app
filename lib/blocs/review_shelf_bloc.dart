import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';

class ReviewShelfBloc extends ChangeNotifier {
  String byType = "Author";

  String byView = "List";
  BookModel mBookModel = BookModelImpl();
  List<BookVO>? reviewShelfBooks;
  List<BookVO>? selectedCategoriesBooksList;
  List<String?> categoriesStringList = [];
  List<String> selectedCategoriesStringList = [];
  List<BookVO> booksByCategory = [];
  List<ShelfVO>? shelfList;
  bool isSelectedCategory = false;
  List<BookVO> addBooks = [];
  int? index;
  bool isRename = false;
  String? shelfName;

  ReviewShelfBloc(List<BookVO> bookList, int shelfIndex, String name,
      [BookModel? bookModel]) {
    if (bookModel != null) {
      mBookModel = bookModel;
    }
    reviewShelfBooks = bookList;
    index = shelfIndex;
    shelfName = name;
    notifyListeners();

    List<BookVO> books = bookList.map((e) {
          categoriesStringList.add(e.category);
          List<String?> cate = categoriesStringList.toSet().toList();
          categoriesStringList = cate;
          notifyListeners();
          return e;
        }).toList() ??
        [];
  }

  void sortByType(String? type, BuildContext context) {
    if (type != null) {
      byType = type;
      if (byType == "Author") {
        reviewShelfBooks
            ?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
        booksByCategory
            .sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
      } else if (byType == "Title") {
        reviewShelfBooks
            ?.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
        booksByCategory
            .sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
      } else {
        reviewShelfBooks?.sort((a, b) =>
            (b.time ?? DateTime.now()).compareTo(a.time ?? DateTime.now()));
        booksByCategory.sort((a, b) =>
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

  void clearCategories() {
    selectedCategoriesStringList.clear();
    booksByCategory.clear();
    isSelectedCategory = false;
    List<BookVO> books = reviewShelfBooks?.map((e) {
          categoriesStringList.add(e.category);
          List<String?> cate = categoriesStringList.toSet().toList();
          categoriesStringList = cate;
          notifyListeners();
          return e;
        }).toList() ??
        [];

    notifyListeners();
  }

  void unselectCategory(int index) {
    isSelectedCategory = false;
    List<BookVO>? books = reviewShelfBooks
            ?.where((element) =>
                (element.category) == (selectedCategoriesStringList[index]))
            .map((book) {
          return book;
        }).toList() ??
        [];

    print("book library => ${categoriesStringList[index]}");
    categoriesStringList.add(selectedCategoriesStringList[index]);
    // selectedCategoriesStringList.removeAt(index);
    booksByCategory.removeWhere((element) =>
        (element.category) == (selectedCategoriesStringList[index]));
    selectedCategoriesStringList
        .remove(selectedCategoriesStringList[index] ?? "");
    notifyListeners();
  }

  void selectOrUnselectCategory(int index) {
    List<BookVO>? books = reviewShelfBooks
            ?.where((element) =>
                (element.category) == (categoriesStringList[index]))
            .map((book) {
          return book;
        }).toList() ??
        [];
    // if (isSelectedCategory) {
    print("book library => ${categoriesStringList[index]}");

    booksByCategory.addAll(books);

    selectedCategoriesStringList.add(categoriesStringList[index] ?? "");
    categoriesStringList.removeAt(index);

    notifyListeners();
  }

  void boolIsRename() {
    isRename = true;
    notifyListeners();
  }

  void editShelf(String shelfName, String editShelfName) {
    isRename = false;
    notifyListeners();
    print("Before edit shelf name => ${shelfName}");
    ShelfVO shelf = ShelfVO(shelfName: editShelfName, books: reviewShelfBooks);
    print("after add to shelf=>${shelf.shelfName.toString()}");
    mBookModel.getSingleShelf(shelfName).then((value) {
      value?.shelfName = editShelfName;

      mBookModel.editShelf(index ?? 0, shelf);
      shelfName = editShelfName;
      notifyListeners();
    });
  }

  void deleteShelf() {
    mBookModel.deleteShelf(index ?? 0);
    notifyListeners();
  }
}
