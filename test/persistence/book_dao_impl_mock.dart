import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/persistence/daos/book_dao.dart';

import '../mock_data/mock_data.dart';

class BookDaoImplMock extends BookDao {
  Map<String, BookVO> booksInDatabaseMock = {};

  @override
  List<BookVO> getAllBooks() {
    return getMockBook();
  }

  @override
  Stream<void> getAllBooksEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<BookVO> getAllRecentBooks() {
    if (getMockBook().isNotEmpty) {
      return getMockBook();
    } else {
      return [];
    }
  }

  @override
  Stream<void> getAllRecentBooksEventStream() {
    return Stream<void>.value(null);
  }

  @override
  BookVO? getBook(String bookTitle) {
    return booksInDatabaseMock.values
        .toList()
        .firstWhere((element) => element.title == bookTitle);
  }

  @override
  List<BookVO> getBooks() {
    if (getMockBook().isNotEmpty) {
      return getMockBook();
    } else {
      return [];
    }
  }

  @override
  Stream<List<BookVO>> getBooksStream() {
    return Stream.value(getMockBook());
  }

  @override
  List<BookVO> getRecentBooks() {
    if (getMockBook().isNotEmpty) {
      return getMockBook();
    } else {
      return [];
    }
  }

  @override
  Stream<List<BookVO>> getRecentBooksStream() {
    return Stream.value(getMockBook());
  }

  @override
  void saveAllBooks(List<BookVO> booksList) {
    booksList.forEach((book) {
      booksInDatabaseMock[book.title ?? ""] = book;
    });
  }

  @override
  void saveRecentAllBooks(List<BookVO> booksList) {
    booksList.forEach((book) {
      booksInDatabaseMock[book.title ?? ""] = book;
    });
  }

  @override
  void saveSingleBook(BookVO book) {
    booksInDatabaseMock[book.title ?? ""] = book;
  }
}
