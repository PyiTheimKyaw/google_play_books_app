import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

abstract class BookModel {
  Future<OverviewVo?> getCategories();
  Future<List<CategoryVO>?> getBooksList(
      String list, String bestSellersDate, String publishedDate);
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList);
  Future<BookVO?> saveSingleBook(BookVO book);
  Future<List<BookVO>?> getSearchBooks(String query);

  ///Database
  Stream<List<BookVO>?> getAllBooksFromDatabase();
  Stream<List<BookVO>?> getAllRecentBooksFromDatabase();
  Future<BookVO?> getSingleBookFromDatabase(String bookTitle);
}
