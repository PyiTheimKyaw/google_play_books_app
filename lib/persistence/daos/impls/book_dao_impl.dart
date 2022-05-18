import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/persistence/daos/book_dao.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';

class BookDaoImpl extends BookDao {
  @override
  void saveAllBooks(List<BookVO> booksList) async {
    Map<String, BookVO> booksMap = Map.fromIterable(booksList,
        key: (book) => book.title, value: (book) => book);
    await getBookBox().putAll(booksMap);
  }

  @override
  void saveRecentAllBooks(List<BookVO> booksList) async {
    Map<String, BookVO> booksMap = Map.fromIterable(booksList,
        key: (book) => book.title, value: (book) => book);
    await getBookBoxForRecent().putAll(booksMap);
  }

  @override
  void saveSingleBook(BookVO book) async {
    await getBookBoxForRecent().put(book.title, book);
  }

  @override
  BookVO? getBook(String bookTitle) {
    return getBookBoxForRecent().get(bookTitle);
  }

  @override
  List<BookVO> getAllBooks() {
    return getBookBox().values.toList();
  }

  @override
  List<BookVO> getAllRecentBooks() {
    return getBookBoxForRecent().values.toList();
  }

  ///Reactive Programming
  Stream<void> getAllBooksEventStream() {
    return getBookBox().watch();
  }

  Stream<void> getAllRecentBooksEventStream() {
    return getBookBoxForRecent().watch();
  }

  List<BookVO> getBooks() {
    if (getAllBooks() != null && getAllBooks().isNotEmpty ?? false) {
      return getAllBooks();
    } else {
      return [];
    }
  }

  List<BookVO> getRecentBooks() {
    if (getAllRecentBooks() != null && getAllRecentBooks().isNotEmpty ??
        false) {
      return getAllRecentBooks();
    } else {
      return [];
    }
  }

  Stream<List<BookVO>> getBooksStream() {
    return Stream.value(getAllBooks());
  }

  Stream<List<BookVO>> getRecentBooksStream() {
    return Stream.value(getAllRecentBooks());
  }

  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO);
  }

  Box<BookVO> getBookBoxForRecent() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO_FOR_RECENT);
  }
}
