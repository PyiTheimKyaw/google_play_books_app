// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OverviewVOAdapter extends TypeAdapter<OverviewVo> {
  @override
  final int typeId = 1;

  @override
  OverviewVo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OverviewVo(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      (fields[5] as List?)?.cast<CategoryVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, OverviewVo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bestSellersDate)
      ..writeByte(1)
      ..write(obj.publishedDate)
      ..writeByte(2)
      ..write(obj.publishedDateDescription)
      ..writeByte(3)
      ..write(obj.previousPublishedDate)
      ..writeByte(4)
      ..write(obj.nextPublishedDate)
      ..writeByte(5)
      ..write(obj.lists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverviewVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
