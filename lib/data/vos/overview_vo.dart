import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overview_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_OVERVIEW_VO,adapterName: 'OverviewVOAdapter')
class OverviewVo {
  @JsonKey(name: 'bestsellers_date')
  @HiveField(0)
  String? bestSellersDate;
  @JsonKey(name: 'published_date')
  @HiveField(1)
  String? publishedDate;
  @JsonKey(name: 'published_date_description')
  @HiveField(2)
  String? publishedDateDescription;
  @JsonKey(name: 'previous_published_date')
  @HiveField(3)
  String? previousPublishedDate;
  @JsonKey(name: 'next_published_date')
  @HiveField(4)
  String? nextPublishedDate;
  @JsonKey(name: 'lists')
  @HiveField(5)
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverviewVo &&
          runtimeType == other.runtimeType &&
          nextPublishedDate == other.nextPublishedDate;

  @override
  int get hashCode => nextPublishedDate.hashCode;
}
