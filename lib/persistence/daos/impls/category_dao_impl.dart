import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/persistence/daos/category_dao.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';

class CategoryDaoImpl extends CategoryDao {
  static final CategoryDaoImpl _singleton = CategoryDaoImpl._internal();

  factory CategoryDaoImpl() {
    return _singleton;
  }

  CategoryDaoImpl._internal();

  @override
  void saveAllCategories(List<CategoryVO> categoryList) async {
    Map<int, CategoryVO> categoryMap = Map.fromIterable(categoryList,
        key: (category) => category.listId, value: (category) => category);
    await getCategoryBox().putAll(categoryMap);
  }

  @override
  List<CategoryVO> getAllCategories() {
    return getCategoryBox().values.toList();
  }

  ///Reactive Stream
  @override
  Stream<void> getCategoryEventStream() {
    return getCategoryBox().watch();
  }

  @override
  List<CategoryVO>? getCategories() {
    if (getAllCategories() != null && getAllCategories().isNotEmpty ?? false) {
      return getAllCategories();
    } else {
      return [];
    }
  }

  @override
  Stream<List<CategoryVO>?> getCategoryStream() {
    return Stream.value(getAllCategories());
  }

  Box<CategoryVO> getCategoryBox() {
    return Hive.box<CategoryVO>(BOX_NAME_CATEGORY_VO);
  }
}
