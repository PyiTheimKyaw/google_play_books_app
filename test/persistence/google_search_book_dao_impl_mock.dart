import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/google_search_vo.dart';
import 'package:google_play_books_app/persistence/daos/google_search_book_dao.dart';

import '../mock_data/mock_data.dart';

class GoogleSearchBookDaoImplMock extends GoogleSearchBookDao {
  Map<String, BookVO> searchBooksInDatabaseMock = {};

  @override
  List<BookVO> getAllBooks() {
    return getMockSearchedBook();
  }

  @override
  Stream<void> getAllBooksEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<BookVO> getBooks() {
    if (getMockSearchedBook().isNotEmpty) {
      return getMockSearchedBook();
    } else {
      return [];
    }
  }

  @override
  Stream<List<BookVO>> getBooksStream() {
    return Stream.value(getMockSearchedBook());
  }

  @override
  void saveAllBooks(List<BookVO> booksList) {
    booksList.forEach((book) {
      searchBooksInDatabaseMock[book.title ?? ''] = book;
    });
  }
}
