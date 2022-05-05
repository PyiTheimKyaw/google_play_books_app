import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookListVO{
  String? listName;
  String? displayName;
  String? bestSellersDate;
  String? publishedDate;
  int? rank;
}