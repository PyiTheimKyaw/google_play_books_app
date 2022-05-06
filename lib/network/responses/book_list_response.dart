import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book_list_response.g.dart';
@JsonSerializable()
class BookListResponse{
  @HiveField(0)
  int? numResults;
  @HiveField(1)
  List<CategoryVO>? results;

  BookListResponse(this.numResults, this.results);

  factory BookListResponse.fromJson(Map<String,dynamic> json) =>_$BookListResponseFromJson(json);
  Map<String,dynamic> toJson() => _$BookListResponseToJson(this);
}