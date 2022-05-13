import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

abstract class BookModel {
  Future<OverviewVo?> getOverview();
  void getBookListFromCategory();
  void getCategoriesList();
  Future<List<CategoryVO>?> getBooksList(
      String list, String bestSellersDate, String publishedDate);
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList);
  Future<BookVO?> saveSingleBook(BookVO book);
  void getSearchBooks(String query);
  Future<List<String?>?> getCategoriesStringList();

  ///Database
  Stream<List<CategoryVO>?> getCategoriesListFromDatabase();
  Stream<List<BookVO>?> getAllBooksFromDatabase();
  Stream<List<BookVO>?> getAllRecentBooksFromDatabase();
  Stream<List<BookVO>?> getSearchedBooksFromDatabase(String query);
  Future<BookVO?> getSingleBookFromDatabase(String bookTitle);
}
