import 'package:dio/dio.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_strings.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/databases/cache/cache_helper.dart';

class ApiConsumer {
  static final Dio _dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl, headers: {
    'Content-Type': 'application/json',
    'token': CacheHelper().getData(key: ApiKey.token) == null
        ? null
        : 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}'
  }));
  ApiConsumer() {
    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }
  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    Response response = await _dio.post(
      path,
      data: isFormData ? FormData.fromMap(data!) : data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    Response response = await _dio.get(
      path,
      data: isFormData ? FormData.fromMap(data!) : data,
      queryParameters: queryParameters,
    );
    return response;
  }
}
