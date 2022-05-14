import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/data/vos/shelf_vo.dart';

abstract class BookModel {
  Future<OverviewVo?> getOverview();
  void getBookListFromCategory();
  void getCategoriesList();
  Future<List<CategoryVO>?> getBooksListForViewMore(
      String list, String bestSellersDate, String publishedDate);
  Future<List<BookVO>?> saveAllRecentBooks(List<BookVO> booksList);
  Future<BookVO?> saveSingleBook(BookVO book);
  void getSearchBooks(String query);
  Future<List<String?>?> getCategoriesStringList();
  Future<List<ShelfVO>?> saveAllShelves(List<ShelfVO> shelfList);
  Future<ShelfVO?> saveSingleShelf(ShelfVO? shelf);
  void deleteShelf(int index);
  Future<ShelfVO?> getSingleShelf(String shelfName);
  void editShelf(int index, ShelfVO shelf);

  ///Database
  Stream<List<CategoryVO>?> getCategoriesListFromDatabase();
  Stream<List<BookVO>?> getAllBooksFromDatabase();
  Stream<List<BookVO>?> getAllRecentBooksFromDatabase();
  Stream<List<BookVO>?> getSearchedBooksFromDatabase(String query);
  Future<BookVO?> getSingleBookFromDatabase(String bookTitle);
  Stream<List<ShelfVO>?> getAllShelvesFromDatabase();
}
