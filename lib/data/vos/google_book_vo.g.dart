// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBooksVO _$GoogleBooksVOFromJson(Map<String, dynamic> json) =>
    GoogleBooksVO(
      json['title'] as String?,
      (json['author'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['publisher'] as String?,
      json['publishedDate'] as String?,
      json['description'] as String?,
      json['industryIdentifiers'] as List<dynamic>?,
      json['imageLinks'] == null
          ? null
          : ImageLinkVO.fromJson(json['imageLinks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleBooksVOToJson(GoogleBooksVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'industryIdentifiers': instance.industryIdentifiers,
      'imageLinks': instance.imageLinks,
    };
