import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

abstract class BookModel {
  Future<OverviewVo?> getCategories();
  Future<List<CategoryVO>?> getBooksList(
      String list, String bestSellersDate, String publishedDate);
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList);
  Future<BookVO?> saveSingleBook(BookVO book);

  ///Database
  Future<List<BookVO>?> getAllBooks();
  Future<List<BookVO>?> getAllRecentBooks();
  Future<BookVO?> getSingleBook(String bookTitle);
}
