import 'package:google_play_books_app/data/vos/shelf_vo.dart';
import 'package:google_play_books_app/persistence/daos/shelf_dao.dart';

import '../mock_data/mock_data.dart';

class ShelfDaoImplMock extends ShelfDao {
  Map<String?, ShelfVO> shelvesInDatabaseMock = {};

  @override
  void deleteShelf(int index) {
    // TODO: implement deleteShelf
  }

  @override
  void editShelf(int index, ShelfVO shelf) {
    // TODO: implement editShelf
  }

  @override
  List<ShelfVO> getAllShelves() {
    return getMockShelves();
  }

  @override
  Stream<void> getShelfEventStream() {
    return Stream.value(null);
  }

  @override
  List<ShelfVO> getShelves() {
    if (getMockShelves() != null && getMockShelves().isNotEmpty ?? false) {
      return getMockShelves();
    } else {
      return [];
    }
  }

  @override
  Stream<List<ShelfVO>> getShelvesStream() {
    return Stream.value(getMockShelves());
  }

  @override
  ShelfVO? getSingleShelf(String shelfName) {
    if (shelfName != null) {
      return shelvesInDatabaseMock.values
          .toList()
          .firstWhere((shelf) => shelf.shelfName == shelfName);
    }
  }

  @override
  void saveAllShelves(List<ShelfVO> shelfList) {
    shelfList.forEach((shelf) {
      shelvesInDatabaseMock[shelf.shelfName] = shelf;
    });
  }

  @override
  void saveSingleShelf(ShelfVO shelf) {
    shelvesInDatabaseMock[shelf.shelfName] = shelf;
  }
}
