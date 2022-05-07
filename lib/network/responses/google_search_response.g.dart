// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSearchResponse _$GoogleSearchResponseFromJson(
        Map<String, dynamic> json) =>
    GoogleSearchResponse(
      json['totalItems'] as int?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => GoogleSearchVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoogleSearchResponseToJson(
        GoogleSearchResponse instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
