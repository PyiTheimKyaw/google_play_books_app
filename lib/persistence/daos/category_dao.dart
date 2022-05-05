import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';

class CategoryDao {
  static final CategoryDao _singleton = CategoryDao._internal();

  factory CategoryDao() {
    return _singleton;
  }

  CategoryDao._internal();

  void saveAllCategories(List<CategoryVO> categoryList) async {
    Map<int, CategoryVO> categoryMap = Map.fromIterable(categoryList,
        key: (category) => category.id, value: (category) => category);
    await getCategoryBox().putAll(categoryMap);
  }

  void saveSingleCategory(CategoryVO category) async {
    return getCategoryBox().put(category.listId, category);
  }

  CategoryVO? getCategory(int categoryId) {
    return getCategoryBox().get(categoryId);
  }

  List<CategoryVO> getAllCategories() {
    return getCategoryBox().values.toList();
  }

  Box<CategoryVO> getCategoryBox() {
    return Hive.box<CategoryVO>(BOX_NAME_CATEGORY_VO);
  }
}
