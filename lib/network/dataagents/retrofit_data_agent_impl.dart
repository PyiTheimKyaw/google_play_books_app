import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/api_constants.dart';
import 'package:google_play_books_app/network/dataagents/book_data_agent.dart';
import 'package:google_play_books_app/network/the_book_api.dart';

class RetrofitDataAgentImpl extends BookDataAgent {
  late TheBookApi mApi;
  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheBookApi(dio);
  }

  @override
  Future<OverviewVo?> getCategories() {
    return mApi
        .getOverview(API_KEY, PUBLISHED_DATE)
        .asStream()
        .map((event) => event.results)
        .first;
  }

  @override
  Future<List<CategoryVO>?> getBooksList(String list,String bestSellersDate,String publishedDate) {
    return mApi.getBookList(list, API_KEY, bestSellersDate, publishedDate, OFFSET)
        .asStream()
        .map((event) => event.results)
        .first;
  }

  @override
  Future<BookVO?> getBook(String list, String bestSellersDate, String publishedDate) {
  return  mApi.getBookList(list, API_KEY, bestSellersDate, publishedDate, OFFSET)
        .asStream()
        .map((event) {
           event.results?.forEach((e) {
             e.bookDetails?.map((b){
               return b;
             });
           });
    }).first;
  }
}
