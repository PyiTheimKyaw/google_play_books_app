// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'the_book_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _TheBookApi implements TheBookApi {
  _TheBookApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.nytimes.com/svc/books/v3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OverviewResponse> getOverview(apiKey, publishedDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api-key': apiKey,
      r'published_date': publishedDate
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OverviewResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/lists/overview.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OverviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookListResponse> getBookList(
      list, apiKey, bestSellersDate, publishedDate, offset) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'list': list,
      r'api-key': apiKey,
      r'bestsellers_date': bestSellersDate,
      r'published_date': publishedDate,
      r'offset': offset
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/lists.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookListResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
