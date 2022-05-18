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
  @override
  Stream<void> getAllBooksEventStream() {
    return getBookBox().watch();
  }

  @override
  Stream<void> getAllRecentBooksEventStream() {
    return getBookBoxForRecent().watch();
  }

  @override
  List<BookVO> getBooks() {
    if (getAllBooks() != null && getAllBooks().isNotEmpty ?? false) {
      return getAllBooks();
    } else {
      return [];
    }
  }

  @override
  List<BookVO> getRecentBooks() {
    if (getAllRecentBooks() != null && getAllRecentBooks().isNotEmpty ??
        false) {
      return getAllRecentBooks();
    } else {
      return [];
    }
  }

  ///Reactive Programming
  @override
  Stream<List<BookVO>> getBooksStream() {
    return Stream.value(getAllBooks());
  }

  @override
  Stream<List<BookVO>> getRecentBooksStream() {
    return Stream.value(getAllRecentBooks());
  }

  @override
  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO);
  }

  @override
  Box<BookVO> getBookBoxForRecent() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO_FOR_RECENT);
  }
}
