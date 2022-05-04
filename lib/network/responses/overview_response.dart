import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'overview_response.g.dart';
@JsonSerializable()
class OverviewResponse{

  @JsonKey(name: 'results')
  OverviewVo? results;

  OverviewResponse(this.results);

  factory OverviewResponse.fromJson(Map<String,dynamic> json) =>_$OverviewResponseFromJson(json);
  Map<String,dynamic> toJson() => _$OverviewResponseToJson(this);
}