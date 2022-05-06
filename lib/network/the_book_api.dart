import 'package:dio/dio.dart';
import 'package:google_play_books_app/network/api_constants.dart';
import 'package:google_play_books_app/network/responses/book_list_response.dart';
import 'package:google_play_books_app/network/responses/overview_response.dart';
import 'package:retrofit/http.dart';

part 'the_book_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class TheBookApi {
  factory TheBookApi(Dio dio) = _TheBookApi;

  @GET(ENDPOINT_GET_OVERVIEW)
  Future<OverviewResponse> getOverview(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_PUBLISHED_DATE) String publishedDate,
  );

  @GET(ENDPOINT_GET_BOOK_LIST)
  Future<BookListResponse> getBookList(
    @Query(PARAM_LIST) String list,
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_BEST_SELLERS_DATE) String bestSellersDate,
    @Query(PARAM_PUBLISHED_DATE) String publishedDate,
    @Query(PARAM_OFFSET) int offset,
  );
}
