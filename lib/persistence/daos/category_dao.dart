import 'package:google_play_books_app/data/vos/category_vo.dart';

abstract class CategoryDao {
  void saveAllCategories(List<CategoryVO> categoryList);
  List<CategoryVO> getAllCategories();
  Stream<void> getCategoryEventStream();
  List<CategoryVO>? getCategories();
  Stream<List<CategoryVO>?> getCategoryStream();
}
