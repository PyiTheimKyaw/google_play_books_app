import 'package:google_play_books_app/data/model/book_model.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';
import 'package:google_play_books_app/network/dataagents/book_data_agent.dart';
import 'package:google_play_books_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:google_play_books_app/persistence/daos/book_dao.dart';
import 'package:google_play_books_app/persistence/daos/category_dao.dart';
import 'package:google_play_books_app/persistence/daos/google_search_book_dao.dart';
import 'package:google_play_books_app/persistence/daos/impls/book_dao_impl.dart';
import 'package:google_play_books_app/persistence/daos/impls/category_dao_impl.dart';
import 'package:google_play_books_app/persistence/daos/impls/google_search_book_dao_impl.dart';
import 'package:google_play_books_app/persistence/daos/impls/shelf_dao_impl.dart';
import 'package:google_play_books_app/persistence/daos/shelf_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class BookModelImpl extends BookModel {
  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl() {
    return _singleton;
  }

  BookModelImpl._internal();

  BookDataAgent mDataAgent = RetrofitDataAgentImpl();

  ///Daos
  BookDao mBookDao = BookDaoImpl();
  CategoryDao mCategoryDao = CategoryDaoImpl();
  GoogleSearchBookDao searchDao = GoogleSearchBookDaoImpl();
  ShelfDao mShelfDao = ShelfDaoImpl();

  void setDaosAndDataAgents(
      BookDao bookDao,
      CategoryDao categoryDao,
      GoogleSearchBookDao googleSearchBookDao,
      ShelfDao shelfDao,
      BookDataAgent dataAgent) {
    mBookDao = bookDao;
    mCategoryDao = categoryDao;
    searchDao = googleSearchBookDao;
    mShelfDao = shelfDao;
    mDataAgent = dataAgent;
  }

  @override
  void getBookListFromCategory() {
    mDataAgent.getCategoriesList().then((value) {
      List<CategoryVO>? category = value?.map((e) {
            List<BookVO>? books = e.books?.map((book) {
                  book.category = e.listName ?? "";
                  book.imageLink = book.bookImage;
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
                  book.category = e.listName;
                  book.imageLink = book.bookImage;
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
  Future<List<CategoryVO>?> getBooksListForViewMore(
      String list, String bestSellersDate, String publishedDate) {
    return mDataAgent
        .getBooksList(list, bestSellersDate, publishedDate)
        .then((value) {
      if (value != null) {
        mCategoryDao.saveAllCategories(value);
      }
      getAllBooksFromDatabase().listen((books) {
        books?.forEach((bookFromDatabase) {
          value?.forEach((element2) {
            element2.bookDetails?.where((book3) => book3.title==bookFromDatabase.title).forEach((book2) {
              book2.bookImage=bookFromDatabase.bookImage;
            });
          });
        });
      });
      // mDataAgent.getCategoriesList().then((cate) {
      //   cate?.forEach((element) {
      //     element.books?.forEach((book1) {
      //       value?.forEach((element2) {
      //         element2.bookDetails?.where((book3) => book3.title==book1.title).forEach((book2) {
      //           book2.bookImage=book1.bookImage;
      //         });
      //       });
      //     });
      //   });
      // });
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

  @override
  Future<List<ShelfVO>?> saveAllShelves(List<ShelfVO> shelfList) {
    mShelfDao.saveAllShelves(shelfList);
    return Future.value(shelfList);
  }

  @override
  Future<ShelfVO?> saveSingleShelf(ShelfVO? shelf) {
    if (shelf != null) {
      mShelfDao.saveSingleShelf(shelf);
    }
    return Future.value(shelf);
  }

  @override
  void deleteShelf(int index) {
    mShelfDao.deleteShelf(index);
  }

  @override
  Future<ShelfVO?> getSingleShelf(String shelfName) {
    return Future.value(mShelfDao.getSingleShelf(shelfName));
  }

  @override
  void editShelf(int index, ShelfVO shelf) {
    mShelfDao.editShelf(index, shelf);
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

  @override
  Stream<List<ShelfVO>?> getAllShelvesFromDatabase() {
    return mShelfDao
        .getShelfEventStream()
        .startWith(mShelfDao.getShelvesStream())
        .map((event) => mShelfDao.getShelves());
  }
}
