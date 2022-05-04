import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overview_vo.g.dart';

@JsonSerializable()
class OverviewVo {
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

  OverviewVo(
      this.bestSellersDate,
      this.publishedDate,
      this.publishedDateDescription,
      this.previousPublishedDate,
      this.nextPublishedDate,
      this.lists);

  factory OverviewVo.fromJson(Map<String, dynamic> json) =>
      _$OverviewVoFromJson(json);

  Map<String, dynamic> toJson() => _$OverviewVoToJson(this);

  @override
  String toString() {
    return 'OverviewVo{bestSellersDate: $bestSellersDate, publishedDate: $publishedDate, publishedDateDescription: $publishedDateDescription, previousPublishedDate: $previousPublishedDate, nextPublishedDate: $nextPublishedDate, lists: $lists}';
  }
}
