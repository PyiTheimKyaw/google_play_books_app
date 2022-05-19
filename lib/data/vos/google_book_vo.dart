import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/image_link_vo.dart';
import 'package:google_play_books_app/persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_book_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_GOOGLE_BOOK_VO,adapterName: 'GoogleBookVOAdapter')
class GoogleBooksVO {
  @JsonKey(name: 'title')
  @HiveField(0)
  String? title;
  @JsonKey(name: 'author')
  @HiveField(1)
  List<String>? author;
  @JsonKey(name: 'publisher')
  @HiveField(2)
  String? publisher;
  @JsonKey(name: 'publishedDate')
  @HiveField(3)
  String? publishedDate;
  @JsonKey(name: 'description')
  @HiveField(4)
  String? description;
  @JsonKey(name: 'industryIdentifiers')
  @HiveField(5)
  List? industryIdentifiers;
  @JsonKey(name: 'imageLinks')
  @HiveField(6)
  ImageLinkVO? imageLinks;
  @JsonKey(name: 'categories')
  @HiveField(7)
  List<String>? categories;


  GoogleBooksVO(this.title, this.author, this.publisher, this.publishedDate,
      this.description, this.industryIdentifiers, this.imageLinks,this.categories);

  factory GoogleBooksVO.fromJson(Map<String, dynamic> json) =>
      _$GoogleBooksVOFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBooksVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoogleBooksVO &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          author == other.author &&
          publisher == other.publisher &&
          publishedDate == other.publishedDate &&
          description == other.description &&
          industryIdentifiers == other.industryIdentifiers &&
          imageLinks == other.imageLinks &&
          categories == other.categories;

  @override
  int get hashCode =>
      title.hashCode ^
      author.hashCode ^
      publisher.hashCode ^
      publishedDate.hashCode ^
      description.hashCode ^
      industryIdentifiers.hashCode ^
      imageLinks.hashCode ^
      categories.hashCode;
}
