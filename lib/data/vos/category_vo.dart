import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_vo.g.dart';
@JsonSerializable()
class CategoryVO {
  @JsonKey(name: 'list_id')
  int? listId;
  @JsonKey(name: 'list_name')
  String? listName;
  @JsonKey(name: 'list_name_encoded')
  String? listNameEncoded;
  @JsonKey(name: 'display_name')
  String? displayName;
  @JsonKey(name: 'updated')
  String? updated;
  @JsonKey(name: 'list_image')
  String? listImage;
  @JsonKey(name: 'list_image_width')
  double? listImageWidth;
  @JsonKey(name: 'list_image_height')
  double? listImageHeight;
  @JsonKey(name: 'books')
  List<BookVO>? books;

  CategoryVO(
      this.listId,
      this.listName,
      this.listNameEncoded,
      this.displayName,
      this.updated,
      this.listImage,
      this.listImageWidth,
      this.listImageHeight,
      this.books);

  factory CategoryVO.fromJson(Map<String,dynamic> json) => _$CategoryVOFromJson(json);
  Map<String,dynamic> toJson() => _$CategoryVOToJson(this);
}
