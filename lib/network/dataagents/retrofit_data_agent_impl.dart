import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_play_books_app/data/vos/book_vo.dart';
import 'package:google_play_books_app/data/vos/category_vo.dart';
import 'package:google_play_books_app/data/vos/overview_vo.dart';
import 'package:google_play_books_app/network/api_constants.dart';
import 'package:google_play_books_app/network/dataagents/book_data_agent.dart';
import 'package:google_play_books_app/network/google_search_api.dart';
import 'package:google_play_books_app/network/the_book_api.dart';

class RetrofitDataAgentImpl extends BookDataAgent {
  late TheBookApi mApi;
  late GoogleSearchApi mGoogleApi;
  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheBookApi(dio);
    mGoogleApi = GoogleSearchApi(dio);
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
  Future<List<CategoryVO>?> getBooksList(
      String list, String bestSellersDate, String publishedDate) {
    return mApi
        .getBookList(list, API_KEY, bestSellersDate, publishedDate, OFFSET)
        .asStream()
        .map((event) => event.results)
        .first;
  }

  @override
  Future<List<BookVO>?> getSearchBooks(String query) {
    return mGoogleApi
        .getSearchedBooks(query)
        .asStream()
        .map((response) =>
            response.items?.map((books) => books.convertToBookVO()).toList())
        .first;
  }
}
