import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CATEGORY_VO,adapterName: 'CategoryVoAdapter')
class CategoryVO {
  @JsonKey(name: 'list_id')
  @HiveField(0)
  int? listId;
  @JsonKey(name: 'list_name')
  @HiveField(1)
  String? listName;
  @JsonKey(name: 'list_name_encoded')
  @HiveField(2)
  String? listNameEncoded;
  @JsonKey(name: 'display_name')
  @HiveField(3)
  String? displayName;
  @JsonKey(name: 'updated')
  @HiveField(4)
  String? updated;
  @JsonKey(name: 'list_image')
  @HiveField(5)
  String? listImage;
  @JsonKey(name: 'list_image_width')
  @HiveField(6)
  double? listImageWidth;
  @JsonKey(name: 'list_image_height')
  @HiveField(7)
  double? listImageHeight;
  @JsonKey(name: 'books')
  @HiveField(8)
  List<BookVO>? books;
  @JsonKey(name: 'bestsellers_date')
  @HiveField(9)
  String? bestSellersDate;
  @JsonKey(name: 'published_date')
  @HiveField(10)
  String? publishedDate;
  @JsonKey(name: 'rank')
  @HiveField(11)
  int? rank;
  @JsonKey(name: 'rank_last_week')
  @HiveField(12)
  int? rankLastWeek;
  @JsonKey(name: 'weeks_on_list')
  @HiveField(13)
  int? weeksOnList;
  @JsonKey(name: 'asterisk')
  @HiveField(14)
  int? asterisk;
  @JsonKey(name: 'dagger')
  @HiveField(15)
  int? dagger;
  @JsonKey(name: 'amazon_product_url')
  @HiveField(16)
  String? amazonProductUrl;
  @JsonKey(name: 'isbns')
  @HiveField(17)
  List? isbns;
  @JsonKey(name: 'book_details')
  @HiveField(18)
  List<BookVO>? bookDetails;
  @JsonKey(name: 'reviews')
  @HiveField(19)
  List? reviews;


  CategoryVO(
      this.listId,
      this.listName,
      this.listNameEncoded,
      this.displayName,
      this.updated,
      this.listImage,
      this.listImageWidth,
      this.listImageHeight,
      this.books,
      this.bestSellersDate,
      this.publishedDate,
      this.rank,
      this.rankLastWeek,
      this.weeksOnList,
      this.asterisk,
      this.dagger,
      this.amazonProductUrl,
      this.isbns,
      this.bookDetails,
      this.reviews);

  factory CategoryVO.fromJson(Map<String,dynamic> json) => _$CategoryVOFromJson(json);
  Map<String,dynamic> toJson() => _$CategoryVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryVO &&
          runtimeType == other.runtimeType &&
          listId == other.listId;

  @override
  int get hashCode => listId.hashCode;
}
