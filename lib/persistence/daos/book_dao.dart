import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';

class BookDao {
  void saveAllBooks(List<BookVO> booksList) async {
    Map<int, BookVO> booksMap = Map.fromIterable(booksList,
        key: (book) => book.id, value: (book) => book);
    await getBookBox().putAll(booksMap);
  }

  void saveSingleBook(BookVO book) async {
    await getBookBox().put(book.title, book);
  }

  BookVO? getBook(String bookTitle) {
    return getBookBox().get(bookTitle);
  }

  List<BookVO> getAllBooks() {
    return getBookBox().values.toList();
  }

  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO);
  }
}
