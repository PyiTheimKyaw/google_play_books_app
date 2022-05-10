import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GoogleSearchBookDao{
  void saveAllBooks(List<BookVO> booksList) async {
    Map<String, BookVO> booksMap = Map.fromIterable(booksList,
        key: (book) => book.title, value: (book) => book);
    await getBookBox().putAll(booksMap);
  }
  List<BookVO> getAllBooks() {
    return getBookBox().values.toList();
  }

  ///Reactive
  Stream<void> getAllBooksEventStream() {
    return getBookBox().watch();
  }
  List<BookVO> getBooks() {
    if (getAllBooks() != null && getAllBooks().isNotEmpty ?? false) {
      return getAllBooks();
    } else {
      return [];
    }
  }
  Stream<List<BookVO>> getBooksStream(){
    return Stream.value(getAllBooks());
  }
  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_GOOGLE_SEARCH_VO);
  }
}