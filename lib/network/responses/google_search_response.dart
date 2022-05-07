import 'package:google_play_books_app/data/vos/google_book_vo.dart';
import 'package:google_play_books_app/data/vos/google_search_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'google_search_response.g.dart';
@JsonSerializable()

class GoogleSearchResponse{
  @JsonKey(name: 'totalItems')
  int? totalItems;
  @JsonKey(name: 'items')
  List<GoogleSearchVO>? items;

  GoogleSearchResponse(this.totalItems, this.items);
  factory GoogleSearchResponse.fromJson(Map<String,dynamic> json) =>_$GoogleSearchResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GoogleSearchResponseToJson(this);

}