import 'package:google_play_books_app/data/vos/book_vo.dart';

abstract class GoogleSearchBookDao {
  void saveAllBooks(List<BookVO> booksList);
  List<BookVO> getAllBooks();
  Stream<void> getAllBooksEventStream();
  List<BookVO> getBooks();
  Stream<List<BookVO>> getBooksStream();
}
