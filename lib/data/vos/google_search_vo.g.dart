// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_search_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoogleSearchBookVOAdapter extends TypeAdapter<GoogleSearchVO> {
  @override
  final int typeId = 6;

  @override
  GoogleSearchVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoogleSearchVO(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as GoogleBooksVO?,
    );
  }

  @override
  void write(BinaryWriter writer, GoogleSearchVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.kind)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.etag)
      ..writeByte(3)
      ..write(obj.volumeInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoogleSearchBookVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
