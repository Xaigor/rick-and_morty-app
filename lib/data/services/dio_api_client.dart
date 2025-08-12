import 'package:dio/dio.dart';

import 'api_client.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient([Dio? dio]) : _dio = dio ?? Dio();

  @override
  Future<dynamic> get(String path,
      {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    final response = await _dio.get(path,
        options: Options(headers: headers), queryParameters: query);
    return response.data;
  }

  @override
  Future<dynamic> post(String path,
      {Map<String, String>? headers, Object? body}) async {
    final response =
        await _dio.post(path, data: body, options: Options(headers: headers));
    return response.data;
  }
}
