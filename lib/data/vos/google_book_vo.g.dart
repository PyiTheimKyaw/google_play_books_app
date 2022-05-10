// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoogleBookVOAdapter extends TypeAdapter<GoogleBooksVO> {
  @override
  final int typeId = 5;

  @override
  GoogleBooksVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoogleBooksVO(
      fields[0] as String?,
      (fields[1] as List?)?.cast<String>(),
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      (fields[5] as List?)?.cast<dynamic>(),
      fields[6] as ImageLinkVO?,
      (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GoogleBooksVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.publisher)
      ..writeByte(3)
      ..write(obj.publishedDate)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.industryIdentifiers)
      ..writeByte(6)
      ..write(obj.imageLinks)
      ..writeByte(7)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoogleBookVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
      'categories': instance.categories,
    };
