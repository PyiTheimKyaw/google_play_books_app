import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/image_link_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_book_vo.g.dart';

@JsonSerializable()
class GoogleBooksVO {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'author')
  List<String>? author;
  @JsonKey(name: 'publisher')
  String? publisher;
  @JsonKey(name: 'publishedDate')
  String? publishedDate;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'industryIdentifiers')
  List? industryIdentifiers;
  @JsonKey(name: 'imageLinks')
  ImageLinkVO? imageLinks;

  GoogleBooksVO(this.title, this.author, this.publisher, this.publishedDate,
      this.description, this.industryIdentifiers, this.imageLinks);

  factory GoogleBooksVO.fromJson(Map<String, dynamic> json) =>
      _$GoogleBooksVOFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBooksVOToJson(this);


}
