// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryVoAdapter extends TypeAdapter<CategoryVO> {
  @override
  final int typeId = 2;

  @override
  CategoryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as double?,
      fields[7] as double?,
      (fields[8] as List?)?.cast<BookVO>(),
      fields[9] as String?,
      fields[10] as String?,
      fields[11] as int?,
      fields[12] as int?,
      fields[13] as int?,
      fields[14] as int?,
      fields[15] as int?,
      fields[16] as String?,
      (fields[17] as List?)?.cast<dynamic>(),
      (fields[18] as List?)?.cast<BookVO>(),
      (fields[19] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryVO obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.listId)
      ..writeByte(1)
      ..write(obj.listName)
      ..writeByte(2)
      ..write(obj.listNameEncoded)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.updated)
      ..writeByte(5)
      ..write(obj.listImage)
      ..writeByte(6)
      ..write(obj.listImageWidth)
      ..writeByte(7)
      ..write(obj.listImageHeight)
      ..writeByte(8)
      ..write(obj.books)
      ..writeByte(9)
      ..write(obj.bestSellersDate)
      ..writeByte(10)
      ..write(obj.publishedDate)
      ..writeByte(11)
      ..write(obj.rank)
      ..writeByte(12)
      ..write(obj.rankLastWeek)
      ..writeByte(13)
      ..write(obj.weeksOnList)
      ..writeByte(14)
      ..write(obj.asterisk)
      ..writeByte(15)
      ..write(obj.dagger)
      ..writeByte(16)
      ..write(obj.amazonProductUrl)
      ..writeByte(17)
      ..write(obj.isbns)
      ..writeByte(18)
      ..write(obj.bookDetails)
      ..writeByte(19)
      ..write(obj.reviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryVO _$CategoryVOFromJson(Map<String, dynamic> json) => CategoryVO(
      json['list_id'] as int?,
      json['list_name'] as String?,
      json['list_name_encoded'] as String?,
      json['display_name'] as String?,
      json['updated'] as String?,
      json['list_image'] as String?,
      (json['list_image_width'] as num?)?.toDouble(),
      (json['list_image_height'] as num?)?.toDouble(),
      (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['rank'] as int?,
      json['rank_last_week'] as int?,
      json['weeks_on_list'] as int?,
      json['asterisk'] as int?,
      json['dagger'] as int?,
      json['amazon_product_url'] as String?,
      json['isbns'] as List<dynamic>?,
      (json['book_details'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['reviews'] as List<dynamic>?,
    );

Map<String, dynamic> _$CategoryVOToJson(CategoryVO instance) =>
    <String, dynamic>{
      'list_id': instance.listId,
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'display_name': instance.displayName,
      'updated': instance.updated,
      'list_image': instance.listImage,
      'list_image_width': instance.listImageWidth,
      'list_image_height': instance.listImageHeight,
      'books': instance.books,
      'bestsellers_date': instance.bestSellersDate,
      'published_date': instance.publishedDate,
      'rank': instance.rank,
      'rank_last_week': instance.rankLastWeek,
      'weeks_on_list': instance.weeksOnList,
      'asterisk': instance.asterisk,
      'dagger': instance.dagger,
      'amazon_product_url': instance.amazonProductUrl,
      'isbns': instance.isbns,
      'book_details': instance.bookDetails,
      'reviews': instance.reviews,
    };
