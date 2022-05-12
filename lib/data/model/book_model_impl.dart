import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/data_agents/book_data_agent.dart';
import 'package:google_play_books_app/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:google_play_books_app/persistence/daos/book_dao.dart';
import 'package:google_play_books_app/persistence/daos/category_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class BookModelImpl extends BookModel {
  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl() {
    return _singleton;
  }

  BookModelImpl._internal();

  BookDataAgent mDataAgent = RetrofitDataAgentImpl();

  ///Daos
  BookDao mBookDao = BookDao();
  CategoryDao mCategoryDao = CategoryDao();

  @override
  void getCategoriesList() {
    mDataAgent.getCategoriesList().then((categoryList) {
      if (categoryList != null) {
        mCategoryDao.saveAllCategories(categoryList);
      }
      List<CategoryVO>? category = categoryList?.map((e) {
        List<BookVO>? books = e.books?.map((book) {
          book.category=e.listName ?? "";
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
  Future<OverviewVo?> getOverview() {
    return Future.value(mDataAgent.getOverview());
  }

  @override
  void getBookList() {
    mDataAgent.getCategoriesList().then((value) {
      List<CategoryVO>? category = value?.map((e) {
            List<BookVO>? books = e.books?.map((book) {
                  book.category=e.listName ?? "";
                  return book;
                }).toList() ??
                [];
            mBookDao.saveAllBooks(books);
            return e;
          }).toList() ??
          [];
    });
  }

  ///Database
  @override
  Stream<List<CategoryVO>?> getCategoriesListFromDatabase() {
    getCategoriesList();
    return mCategoryDao
        .getCategoryEventStream()
        .startWith(mCategoryDao.getCategoryStream())
        .map((event) => mCategoryDao.getCategories());
  }

  @override
  Stream<List<BookVO>?> getAllBooksFromDatabase() {
    getBookList();
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getBooksStream())
        .map((event) => mBookDao.getBooks());
  }
}
