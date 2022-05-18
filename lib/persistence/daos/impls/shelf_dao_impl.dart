import 'package:google_play_books_app/data/vos/shelf_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShelfDao {
  void saveAllShelves(List<ShelfVO> shelfList) async {
    Map<String, ShelfVO> shelfMap = Map.fromIterable(shelfList,
        key: (shelf) => shelf.shelfName, value: (shelfValue) => shelfValue);
    await getShelBox().putAll(shelfMap);
  }

  void saveSingleShelf(ShelfVO shelf) async {
    await getShelBox().put(shelf.shelfName, shelf);
  }

  void editShelf(int index, ShelfVO shelf) async {
    await getShelBox().putAt(index, shelf);
  }

  void deleteShelf(int index) async {
    await getShelBox().deleteAt(index);
  }

  ShelfVO? getSingleShelf(String shelfName) {
    return getShelBox().get(shelfName);
  }

  List<ShelfVO> getAllShelves() {
    return getShelBox().values.toList();
  }

  ///Reactive Stream
  Stream<void> getShelfEventStream() {
    return getShelBox().watch();
  }

  List<ShelfVO> getShelves() {
    if (getAllShelves() != null && getAllShelves().isNotEmpty ?? false) {
      return getAllShelves();
    } else {
      return [];
    }
  }

  Stream<List<ShelfVO>> getShelvesStream() {
    return Stream.value(getAllShelves());
  }

  Box<ShelfVO> getShelBox() {
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }
}
