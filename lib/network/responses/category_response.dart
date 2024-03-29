import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_response.g.dart';
@JsonSerializable()
class CategoryResponse{
  @JsonKey(name: 'bestsellers_date')
  String? bestSellersDate;
  @JsonKey(name: 'published_date')
  String? publishedDate;
  @JsonKey(name: 'published_date_description')
  String? publishedDateDescription;
  @JsonKey(name: 'previous_published_date')
  String? previousPublishedDate;
  @JsonKey(name: 'next_published_date')
  String? nextPublishedDate;
  @JsonKey(name: 'lists')
  List<CategoryVO>? lists;

  CategoryResponse(
      this.bestSellersDate,
      this.publishedDate,
      this.publishedDateDescription,
      this.previousPublishedDate,
      this.nextPublishedDate,
      this.lists);

  factory CategoryResponse.fromJson(Map<String,dynamic> json) =>_$CategoryResponseFromJson(json);
  Map<String,dynamic> toJson() => _$CategoryResponseToJson(this);
}