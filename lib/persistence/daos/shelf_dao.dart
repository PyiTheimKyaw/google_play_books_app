import 'package:google_play_books_app/data/vos/shelf_vo.dart';

abstract class ShelfDao {
  void saveAllShelves(List<ShelfVO> shelfList);
  void saveSingleShelf(ShelfVO shelf);
  void editShelf(int index, ShelfVO shelf);
  void deleteShelf(int index);
  ShelfVO? getSingleShelf(String shelfName);
  List<ShelfVO> getAllShelves();
  Stream<void> getShelfEventStream();
  List<ShelfVO> getShelves();
  Stream<List<ShelfVO>> getShelvesStream();
}
