import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/dataagents/book_data_agent.dart';
import 'package:google_play_books_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:google_play_books_app/persistence/daos/book_dao.dart';
import 'package:google_play_books_app/persistence/daos/category_dao.dart';
import 'package:google_play_books_app/persistence/daos/google_search_book_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class BookModelImpl extends BookModel {
  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl() {
    return _singleton;
  }

  BookModelImpl._internal();

  BookDataAgent mDataAgent = RetrofitDataAgentImpl();

  BookDao mBookDao = BookDao();
  CategoryDao mCategoryDao = CategoryDao();

  GoogleSearchBookDao searchDao = GoogleSearchBookDao();

  @override
  void getBookListFromCategory() {
    mDataAgent.getCategoriesList().then((value) {
      List<CategoryVO>? category = value?.map((e) {
            List<BookVO>? books = e.books?.map((book) {
                  book.category = e.listName ?? "";
                  return book;
                }).toList() ??
                [];
            mBookDao.saveAllBooks(books);
            return e;
          }).toList() ??
          [];
    });
  }

  @override
  void getCategoriesList() {
    mDataAgent.getCategoriesList().then((categoryList) {
      if (categoryList != null) {
        mCategoryDao.saveAllCategories(categoryList);
      }
      List<CategoryVO>? category = categoryList?.map((e) {
            List<BookVO>? books = e.books?.map((book) {
                  book.category = e.listName ?? "";
                  book.imageUrl = book.bookImage ?? "";
                  return book;
                }).toList() ??
                [];
            mBookDao.saveAllBooks(books);
            return e;
          }).toList() ??
          [];
    });
  }

  @override
  Future<List<CategoryVO>?> getBooksList(
      String list, String bestSellersDate, String publishedDate) {
    return mDataAgent
        .getBooksList(list, bestSellersDate, publishedDate)
        .then((value) {
      List<CategoryVO>? category = value?.map((e) {
            List<BookVO>? books = e.books?.map((book) {
                  book.category = e.listName ?? "";
                  book.imageUrl = book.bookImage ?? "";
                  return book;
                }).toList() ??
                [];
            mBookDao.saveAllBooks(books);
            return e;
          }).toList() ??
          [];
      // List<CategoryVO>? categoryList = value?.map((e) {
      //   e.bookDetails?.map((e) {
      //     e.time = DateTime.now();
      //   });
      //   return e;
      // }).toList();
      // categoryList?.map((e) {
      //   bookDao.saveAllBooks(e.bookDetails ?? []);
      // });
      // value?.map((e) => {bookDao.saveAllBooks(e.bookDetails ?? [])}).toList();
      return Future.value(value);
    });
  }

  @override
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList) {
    mBookDao.saveRecentAllBooks(booksList);
    return Future.value(booksList);
  }

  @override
  Future<BookVO?> saveSingleBook(BookVO book) {
    return mDataAgent.getCategoriesList().then((categoriesList) {
      mBookDao.saveSingleBook(book);
      return Future.value(book);
    });
  }

  @override
  Future<OverviewVo?> getOverview() {
    return mDataAgent.getOverview().then((value) {
      value?.lists?.map((e) {
        mBookDao.saveAllBooks(e.books ?? []);
      }).toList();
      return Future.value(value);
    });
  }

  @override
  void getSearchBooks(String query) {
    mDataAgent.getSearchBooks(query).then((value) {
      if (value != null) {
        mBookDao.saveAllBooks(value);
      }
    });
  }

  @override
  Future<List<String?>?> getCategoriesStringList() {
    return Future.value(mDataAgent.categoriesString());
  }

  ///Database
  @override
  Stream<List<BookVO>?> getAllBooksFromDatabase() {
    getBookListFromCategory();
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getBooksStream())
        .map((event) => mBookDao.getBooks());
  }

  @override
  Future<BookVO?> getSingleBookFromDatabase(String bookTitle) {
    return Future.value(mBookDao.getBook(bookTitle));
  }

  @override
  Stream<List<BookVO>?> getAllRecentBooksFromDatabase() {
    return mBookDao
        .getAllRecentBooksEventStream()
        .startWith(mBookDao.getRecentBooksStream())
        .map((event) => mBookDao.getRecentBooks());
  }

  @override
  Stream<List<BookVO>?> getSearchedBooksFromDatabase(String query) {
    getSearchBooks(query);
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getBooksStream())
        .map((event) => mBookDao.getBooks());
  }

  @override
  Stream<List<CategoryVO>?> getCategoriesListFromDatabase() {
    getCategoriesList();
    return mCategoryDao
        .getCategoryEventStream()
        .startWith(mCategoryDao.getCategoryStream())
        .map((event) => mCategoryDao.getCategories());
  }
}
