import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_response.g.dart';
@JsonSerializable()
class CategoryResponse{
  @JsonKey(name: 'num_results')
  int? numResults;
  @JsonKey(name: 'results')
  List<CategoryVO>? results;

  CategoryResponse(this.numResults, this.results);

  factory CategoryResponse.fromJson(Map<String,dynamic> json) => _$CategoryResponseFromJson(json);
  Map<String,dynamic> toJson() => _$CategoryResponseToJson(this);
}