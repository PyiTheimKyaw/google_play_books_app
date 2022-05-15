import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/model/book_model_impl.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_list_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';

class LibraryBloc extends ChangeNotifier {
  String byType = "Author";

  String byView = "List";
  BookModel mBookModel = BookModelImpl();
  List<BookVO>? recentBooks;
  List<BookVO>? selectedCategoriesBooksList;
  List<String?>? categoriesStringList;
  List<String> selectedCategoriesStringList = [];
  List<BookVO> booksByCategory = [];
  List<ShelfVO>? shelfList;
  bool isSelectedCategory = false;
  List<BookVO> addBooks = [];

  LibraryBloc() {
    ///Get all categories list
    mBookModel.getCategoriesStringList().then((value) {
      categoriesStringList = value;
      notifyListeners();
    });

    ///Get all recent books
    mBookModel.getAllRecentBooksFromDatabase().listen((books) {
      recentBooks = books;
      notifyListeners();
      recentBooks?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
    });

    mBookModel.getAllShelvesFromDatabase().listen((shelves) {
      shelfList = shelves;
      notifyListeners();
      print("Get shelves from database => ${shelves.toString()}");
    });
  }

  void sortByType(String? type, BuildContext context) {
    if (type != null) {
      byType = type;
      if (byType == "Author") {
        recentBooks?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
        booksByCategory
            .sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
      } else if (byType == "Title") {
        recentBooks?.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
        booksByCategory
            .sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
      } else {
        recentBooks?.sort((a, b) =>
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
    mBookModel.getCategoriesStringList().then((value) {
      categoriesStringList = value;
      notifyListeners();
    });
    notifyListeners();
  }

  void unselectCategory(int index) {
    isSelectedCategory = false;
    List<BookVO>? books = recentBooks
            ?.where((element) =>
                (element.category) == (selectedCategoriesStringList[index]))
            .map((book) {
          return book;
        }).toList() ??
        [];

    print("book library => ${categoriesStringList?[index]}");
    categoriesStringList?.add(selectedCategoriesStringList[index]);
    // selectedCategoriesStringList.removeAt(index);
    booksByCategory.removeWhere((element) =>
        (element.category) == (selectedCategoriesStringList[index]));
    selectedCategoriesStringList
        .remove(selectedCategoriesStringList[index] ?? "");
    notifyListeners();
  }

  void selectOrUnselectCategory(int index) {
    List<BookVO>? books = recentBooks
            ?.where((element) =>
                (element.category) == (categoriesStringList?[index]))
            .map((book) {
          return book;
        }).toList() ??
        [];
    // if (isSelectedCategory) {
    print("book library => ${categoriesStringList?[index]}");

    booksByCategory.addAll(books);
    selectedCategoriesStringList.add(categoriesStringList?[index] ?? "");
    categoriesStringList?.removeAt(index);
    notifyListeners();
  }

  void addNewShelf(String shelfName) {
    ShelfVO shelf = ShelfVO(shelfName: shelfName, books: []);
    List<ShelfVO>? shelves;
    mBookModel.saveSingleShelf(shelf).then((value) {
      shelves?.add(value!);
      mBookModel.saveAllShelves(shelves ?? []);
      notifyListeners();
    });
  }

  void deleteShelf(int index) {
    mBookModel.deleteShelf(index);
    notifyListeners();
  }

  void editShelf(String shelfName, String editShelfName, int index) {
    List<ShelfVO>? editShelf;
    print("Before edit shelf name => ${shelfName}");
    ShelfVO shelf = ShelfVO(shelfName: editShelfName);
    print("after add to shelf=>${shelf.shelfName.toString()}");
    mBookModel.getSingleShelf(shelfName).then((value) {
      value?.shelfName = editShelfName;

      mBookModel.editShelf(index, shelf);
      notifyListeners();
    });
    // mBookModel.editShelf(index, shelf);
    notifyListeners();
  }

  void addToShelf(BookVO? book, String shelfName, int index) {
    print("Book from bookItemView => ${book.toString()}");

    mBookModel.getSingleShelf(shelfName).then((value) {
      value?.books?.add(book!);
      mBookModel.editShelf(index, value!);
      notifyListeners();
    });
  }
}
