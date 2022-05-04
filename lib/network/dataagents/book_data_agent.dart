import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';

abstract class BookDataAgent{

  Future<List<CategoryVO>?> getCategories();
  Future<List<BookVO>?> getBooksList();

}