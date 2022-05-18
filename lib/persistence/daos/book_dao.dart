import 'package:google_play_books_app/data/vos/book_vo.dart';

abstract class BookDao {
  void saveAllBooks(List<BookVO> booksList);

  void saveRecentAllBooks(List<BookVO> booksList);

  void saveSingleBook(BookVO book);

  BookVO? getBook(String bookTitle);

  List<BookVO> getAllBooks();

  List<BookVO> getAllRecentBooks();
}
