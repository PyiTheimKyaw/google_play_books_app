import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

abstract class BookDataAgent{

  Future<OverviewVo?> getCategories();
  Future<List<CategoryVO>?> getBooksList(String list,String bestSellersDate,String publishedDate);
  Future<BookVO?> getBook(String list,String bestSellersDate,String publishedDate);
}