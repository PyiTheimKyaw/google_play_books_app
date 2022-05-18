import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';

class BookModelImplMock extends BookModel {
  @override
  void deleteShelf(int index) {
    // TODO: implement deleteShelf
  }

  @override
  void editShelf(int index, ShelfVO shelf) {
    // TODO: implement editShelf
  }

  @override
  Stream<List<BookVO>?> getAllBooksFromDatabase() {
    // TODO: implement getAllBooksFromDatabase
    throw UnimplementedError();
  }

  @override
  Stream<List<BookVO>?> getAllRecentBooksFromDatabase() {
    // TODO: implement getAllRecentBooksFromDatabase
    throw UnimplementedError();
  }

  @override
  Stream<List<ShelfVO>?> getAllShelvesFromDatabase() {
    // TODO: implement getAllShelvesFromDatabase
    throw UnimplementedError();
  }

  @override
  void getBookListFromCategory() {
    // TODO: implement getBookListFromCategory
  }

  @override
  Future<List<CategoryVO>?> getBooksListForViewMore(
      String list, String bestSellersDate, String publishedDate) {
    // TODO: implement getBooksListForViewMore
    throw UnimplementedError();
  }

  @override
  void getCategoriesList() {
    // TODO: implement getCategoriesList
  }

  @override
  Stream<List<CategoryVO>?> getCategoriesListFromDatabase() {
    // TODO: implement getCategoriesListFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<List<String?>?> getCategoriesStringList() {
    // TODO: implement getCategoriesStringList
    throw UnimplementedError();
  }

  @override
  Future<OverviewVo?> getOverview() {
    // TODO: implement getOverview
    throw UnimplementedError();
  }

  @override
  void getSearchBooks(String query) {
    // TODO: implement getSearchBooks
  }

  @override
  Stream<List<BookVO>?> getSearchedBooksFromDatabase(String query) {
    // TODO: implement getSearchedBooksFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<BookVO?> getSingleBookFromDatabase(String bookTitle) {
    // TODO: implement getSingleBookFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<ShelfVO?> getSingleShelf(String shelfName) {
    // TODO: implement getSingleShelf
    throw UnimplementedError();
  }

  @override
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList) {
    // TODO: implement saveAllRecentBooks
    throw UnimplementedError();
  }

  @override
  Future<List<ShelfVO>?> saveAllShelves(List<ShelfVO> shelfList) {
    // TODO: implement saveAllShelves
    throw UnimplementedError();
  }

  @override
  Future<BookVO?> saveSingleBook(BookVO book) {
    // TODO: implement saveSingleBook
    throw UnimplementedError();
  }

  @override
  Future<ShelfVO?> saveSingleShelf(ShelfVO? shelf) {
    // TODO: implement saveSingleShelf
    throw UnimplementedError();
  }
}
