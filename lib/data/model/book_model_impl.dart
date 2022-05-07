import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/dataagents/book_data_agent.dart';
import 'package:google_play_books_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:google_play_books_app/persistence/daos/book_dao.dart';

class BookModelImpl extends BookModel {
  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl() {
    return _singleton;
  }

  BookModelImpl._internal();

  BookDataAgent mDataAgent = RetrofitDataAgentImpl();

  BookDao bookDao = BookDao();

  @override
  Future<List<CategoryVO>?> getBooksList(
      String list, String bestSellersDate, String publishedDate) {
    return mDataAgent
        .getBooksList(list, bestSellersDate, publishedDate)
        .then((value) {
      // List<CategoryVO>? categoryList = value?.map((e) {
      //   e.bookDetails?.map((e) {
      //     e.time = DateTime.now();
      //   });
      //   return e;
      // }).toList();
      // categoryList?.map((e) {
      //   bookDao.saveAllBooks(e.bookDetails ?? []);
      // });
      value?.map((e) => {bookDao.saveAllBooks(e.bookDetails ?? [])}).toList();
      return Future.value(value);
    });
  }

  @override
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList) {
    bookDao.saveRecentAllBooks(booksList);
    return Future.value(booksList);
  }

  @override
  Future<BookVO?> saveSingleBook(BookVO book) {
    bookDao.saveSingleBook(book);
    return Future.value(book);
  }

  @override
  Future<OverviewVo?> getCategories() {
    return Future.value(mDataAgent.getCategories());
  }

  ///Database
  @override
  Future<List<BookVO>?> getAllBooksFromDatabase() {
    return Future.value(bookDao.getAllBooks());
  }

  @override
  Future<BookVO?> getSingleBookFromDatabase(String bookTitle) {
    return Future.value(bookDao.getBook(bookTitle));
  }

  @override
  Future<List<BookVO>?> getAllRecentBooksFromDatabase() {
    return Future.value(bookDao.getAllRecentBooks());
  }
}
