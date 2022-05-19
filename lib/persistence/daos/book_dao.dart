import 'package:google_play_books_app/data/vos/book_vo.dart';

abstract class BookDao {
  void saveAllBooks(List<BookVO> booksList);

  void saveRecentAllBooks(List<BookVO> booksList);

  void saveSingleBook(BookVO book);

  BookVO? getBook(String bookTitle);

  List<BookVO> getAllBooks();

  List<BookVO> getBooks();

  List<BookVO> getRecentBooks();

  List<BookVO> getAllRecentBooks();

  Stream<void> getAllBooksEventStream();

  Stream<void> getAllRecentBooksEventStream();

  Stream<List<BookVO>> getBooksStream();

  Stream<List<BookVO>> getRecentBooksStream();
}
