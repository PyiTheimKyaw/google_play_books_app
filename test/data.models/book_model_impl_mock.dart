import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';

import '../mock_data/mock_data.dart';

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
    return Stream.value(getMockBook());
  }

  @override
  Stream<List<BookVO>?> getAllRecentBooksFromDatabase() {
    return Stream.value(getMockBook());
  }

  @override
  Stream<List<ShelfVO>?> getAllShelvesFromDatabase() {
    return Stream.value(getMockShelves());
  }

  @override
  void getBookListFromCategory() {
    // TODO: implement getBookListFromCategory
  }

  @override
  Future<List<CategoryVO>?> getBooksListForViewMore(
      String list, String bestSellersDate, String publishedDate) {
    return Future.value(getMockBookListForViewMore());
  }

  @override
  void getCategoriesList() {
    // TODO: implement getCategoriesList
  }

  @override
  Stream<List<CategoryVO>?> getCategoriesListFromDatabase() {
    return Stream.value(getMockBookListForViewMore());
  }

  @override
  Future<List<String?>?> getCategoriesStringList() {
    return Future.value(getMockCategoriesString());
  }

  @override
  Future<OverviewVo?> getOverview() {
    return Future.value(getMockOverview());
  }

  @override
  void getSearchBooks(String query) {
    // TODO: implement getSearchBooks
  }

  @override
  Stream<List<BookVO>?> getSearchedBooksFromDatabase(String query) {
    return Stream.value(getMockBook());
  }

  @override
  Future<BookVO?> getSingleBookFromDatabase(String bookTitle) {
    return Future.value(getMockBook().first);
  }

  @override
  Future<ShelfVO?> getSingleShelf(String shelfName) {
    return Future.value(getMockShelves().first);
  }

  @override
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList) {
    return Future.value(getMockBook());
  }

  @override
  Future<List<ShelfVO>?> saveAllShelves(List<ShelfVO> shelfList) {
    return Future.value(getMockShelves());
  }

  @override
  Future<BookVO?> saveSingleBook(BookVO book) {
    return Future.value(getMockBook().first);
  }

  @override
  Future<ShelfVO?> saveSingleShelf(ShelfVO? shelf) {
    return Future.value(getMockShelves().first);
  }
}
