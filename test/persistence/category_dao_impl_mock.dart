import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/persistence/daos/category_dao.dart';

import '../mock_data/mock_data.dart';

class CategoryDaoImplMock extends CategoryDao {
  Map<int, CategoryVO> categoriesInDatabaseMock = {};

  @override
  List<CategoryVO> getAllCategories() {
    return categoriesInDatabaseMock.values.toList();
  }

  @override
  List<CategoryVO>? getCategories() {
    if (getMockBookListForViewMore().isNotEmpty) {
      return getMockBookListForViewMore();
    } else {
      return [];
    }
  }

  @override
  Stream<void> getCategoryEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<List<CategoryVO>?> getCategoryStream() {
    return Stream.value(getMockBookListForViewMore());
  }

  @override
  void saveAllCategories(List<CategoryVO> categoryList) {
    categoryList.forEach((category) {
      categoriesInDatabaseMock[category.listId ?? 0] = category;
    });
  }
}
