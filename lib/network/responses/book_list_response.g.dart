// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookListResponse _$BookListResponseFromJson(Map<String, dynamic> json) =>
    BookListResponse(
      json['numResults'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => CategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookListResponseToJson(BookListResponse instance) =>
    <String, dynamic>{
      'numResults': instance.numResults,
      'results': instance.results,
    };
