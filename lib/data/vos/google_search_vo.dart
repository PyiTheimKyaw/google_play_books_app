import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/google_book_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'google_search_vo.g.dart';
@JsonSerializable()
class GoogleSearchVO{
  @JsonKey(name: 'kind')
  String? kind;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'etag')
  String? etag;
  @JsonKey(name: 'volumeInfo')
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
        DateTime.now());
  }
}