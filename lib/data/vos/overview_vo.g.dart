// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewVo _$OverviewVoFromJson(Map<String, dynamic> json) => OverviewVo(
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['published_date_description'] as String?,
      json['previous_published_date'] as String?,
      json['next_published_date'] as String?,
      (json['lists'] as List<dynamic>?)
          ?.map((e) => CategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OverviewVoToJson(OverviewVo instance) =>
    <String, dynamic>{
      'bestsellers_date': instance.bestSellersDate,
      'published_date': instance.publishedDate,
      'published_date_description': instance.publishedDateDescription,
      'previous_published_date': instance.previousPublishedDate,
      'next_published_date': instance.nextPublishedDate,
      'lists': instance.lists,
    };
