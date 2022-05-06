import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

abstract class BookModel{
  Future<OverviewVo?> getCategories();
  Future<List<CategoryVO>?> getBooksList(String list,String bestSellersDate,String publishedDate);
  Future<BookVO?> saveSingleBook(String list,String bestSellersDate,String publishedDate);

  ///Database
  Future<List<BookVO>?> getAllBooks();
  Future<BookVO?> getSingleBook(String bookTitle);

}