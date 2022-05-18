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
        key: (category) => category.listId, value: (category) => category);
    await getCategoryBox().putAll(categoryMap);
  }

  List<CategoryVO> getAllCategories() {
    return getCategoryBox().values.toList();
  }

  ///Reactive Stream
  Stream<void> getCategoryEventStream() {
    return getCategoryBox().watch();
  }

  List<CategoryVO>? getCategories() {
    if (getAllCategories() != null && getAllCategories().isNotEmpty ?? false) {
      return getAllCategories();
    } else {
      return [];
    }
  }

  Stream<List<CategoryVO>?> getCategoryStream() {
    return Stream.value(getAllCategories());
  }

  Box<CategoryVO> getCategoryBox() {
    return Hive.box<CategoryVO>(BOX_NAME_CATEGORY_VO);
  }
}
