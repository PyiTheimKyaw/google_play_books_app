import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';

abstract class BookModel{
  Future<OverviewVo?> getCategories();
  Future<List<BookVO>?> getBooksList();
}