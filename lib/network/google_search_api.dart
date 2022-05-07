import 'package:dio/dio.dart';
import 'package:google_play_books_app/network/api_constants.dart';
import 'package:google_play_books_app/network/responses/google_search_response.dart';
import 'package:retrofit/http.dart';

part 'google_search_api.g.dart';

@RestApi(baseUrl: BASE_GOOGLE_SEARCH_URL)
abstract class GoogleSearchApi {
  factory GoogleSearchApi(Dio dio) = _GoogleSearchApi;

  @GET(ENDPOINT_GET_SEARCHED_BOOKS)
  Future<GoogleSearchResponse> getSearchedBooks(
    @Query(PARAM_QUERY) String q,
  );
}
