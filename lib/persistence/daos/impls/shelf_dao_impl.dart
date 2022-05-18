import 'package:google_play_books_app/data/vos/shelf_vo.dart';
import 'package:google_play_books_app/persistence/daos/shelf_dao.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShelfDaoImpl extends ShelfDao {
  @override
  void saveAllShelves(List<ShelfVO> shelfList) async {
    Map<String, ShelfVO> shelfMap = Map.fromIterable(shelfList,
        key: (shelf) => shelf.shelfName, value: (shelfValue) => shelfValue);
    await getShelBox().putAll(shelfMap);
  }

  @override
  void saveSingleShelf(ShelfVO shelf) async {
    await getShelBox().put(shelf.shelfName, shelf);
  }

  @override
  void editShelf(int index, ShelfVO shelf) async {
    await getShelBox().putAt(index, shelf);
  }

  @override
  void deleteShelf(int index) async {
    await getShelBox().deleteAt(index);
  }

  @override
  ShelfVO? getSingleShelf(String shelfName) {
    return getShelBox().get(shelfName);
  }

  @override
  List<ShelfVO> getAllShelves() {
    return getShelBox().values.toList();
  }

  ///Reactive Stream
  @override
  Stream<void> getShelfEventStream() {
    return getShelBox().watch();
  }

  @override
  List<ShelfVO> getShelves() {
    if (getAllShelves() != null && getAllShelves().isNotEmpty ?? false) {
      return getAllShelves();
    } else {
      return [];
    }
  }

  @override
  Stream<List<ShelfVO>> getShelvesStream() {
    return Stream.value(getAllShelves());
  }

  Box<ShelfVO> getShelBox() {
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }
}
