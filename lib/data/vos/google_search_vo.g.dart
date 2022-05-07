// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_search_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSearchVO _$GoogleSearchVOFromJson(Map<String, dynamic> json) =>
    GoogleSearchVO(
      json['kind'] as String?,
      json['id'] as String?,
      json['etag'] as String?,
      json['volumeInfo'] == null
          ? null
          : GoogleBooksVO.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleSearchVOToJson(GoogleSearchVO instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'volumeInfo': instance.volumeInfo,
    };
