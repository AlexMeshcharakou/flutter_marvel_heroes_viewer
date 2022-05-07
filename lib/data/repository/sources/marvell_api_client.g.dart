// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marvell_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _MarvelClient implements MarvelClient {
  _MarvelClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://gateway.marvel.com:443/v1/public';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<Character>> fetchCharacters(ts, publicKey, hash) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'ts': ts,
      r'apikey': publicKey,
      r'hash': hash
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Character>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/characters',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Character.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
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
