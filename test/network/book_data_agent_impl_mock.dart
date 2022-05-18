import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/dataagents/book_data_agent.dart';

import '../mock_data/mock_data.dart';

class BookDataAgentImplMock extends BookDataAgent {
  @override
  Future<List<String?>?> categoriesString() {
    return Future.value(getMockCategoriesString());
  }

  @override
  Future<List<CategoryVO>?> getBooksList(
      String list, String bestSellersDate, String publishedDate) {
    return Future.value(getMockBookListForViewMore());
  }

  @override
  Future<List<CategoryVO>?> getCategoriesList() {
    return Future.value(getMockBookListForViewMore());
  }

  @override
  Future<OverviewVo?> getOverview() {
    return Future.value(getMockOverview());
  }

  @override
  Future<List<BookVO>?> getSearchBooks(String query) {
    return Future.value(getMockSearchedBook());
  }
}
