import 'package:dio/dio.dart';
import 'package:google_play_books_app/network/api_constants.dart';
import 'package:google_play_books_app/network/responses/category_response.dart';
import 'package:retrofit/http.dart';

part 'the_book_api.g.dart';
@RestApi(baseUrl: BASE_URL)
abstract class TheBookApi {
  factory TheBookApi(Dio dio) = _TheBookApi;

  @GET(ENDPOINT_GET_OVERVIEW)
  Future<CategoryResponse> getList(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_PUBLISHED_DATE) String publishedDate,
  );
}
