import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';
part 'shelf_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_SHELF_VO,adapterName: "ShelfVOAdapter")
class ShelfVO{
  @HiveField(0)
  String? shelfName;
  @HiveField(1)
  List<BookVO>? books;

  ShelfVO(this.shelfName, {this.books});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVO &&
          runtimeType == other.runtimeType &&
          shelfName == other.shelfName &&
          books == other.books;

  @override
  int get hashCode => shelfName.hashCode ^ books.hashCode;
}