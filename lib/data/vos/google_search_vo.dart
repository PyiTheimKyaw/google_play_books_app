import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/google_book_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_search_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_GOOGLE_SEARCH_BOOK_VO,
    adapterName: 'GoogleSearchBookVOAdapter')
class GoogleSearchVO {
  @JsonKey(name: 'kind')
  @HiveField(0)
  String? kind;
  @JsonKey(name: 'id')
  @HiveField(1)
  String? id;
  @JsonKey(name: 'etag')
  @HiveField(2)
  String? etag;
  @JsonKey(name: 'volumeInfo')
  @HiveField(3)
  GoogleBooksVO? volumeInfo;

  GoogleSearchVO(this.kind, this.id, this.etag, this.volumeInfo);

  factory GoogleSearchVO.fromJson(Map<String, dynamic> json) =>
      _$GoogleSearchVOFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleSearchVOToJson(this);

  BookVO convertToBookVO() {
    return BookVO(
        null,
        null,
        null,
        volumeInfo?.author?.join(", "),
        volumeInfo?.imageLinks?.thumbnail,
        null,
        null,
        null,
        volumeInfo?.publisher,
        null,
        null,
        volumeInfo?.description,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        volumeInfo?.title,
        volumeInfo?.publishedDate,
        null,
        null,
        DateTime.now(),
        GoogleSearchVO(kind, id, etag, volumeInfo),
        volumeInfo?.categories?.first,
      "",
        );
  }
}
