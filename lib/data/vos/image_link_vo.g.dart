// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_link_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageLinkVOAdapter extends TypeAdapter<ImageLinkVO> {
  @override
  final int typeId = 7;

  @override
  ImageLinkVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageLinkVO(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageLinkVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.smallThumbnail)
      ..writeByte(1)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageLinkVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageLinkVO _$ImageLinkVOFromJson(Map<String, dynamic> json) => ImageLinkVO(
      json['smallThumbnail'] as String?,
      json['thumbnail'] as String?,
    );

Map<String, dynamic> _$ImageLinkVOToJson(ImageLinkVO instance) =>
    <String, dynamic>{
      'smallThumbnail': instance.smallThumbnail,
      'thumbnail': instance.thumbnail,
    };
