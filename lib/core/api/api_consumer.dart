import 'package:dio/dio.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_strings.dart';

class ApiConsumer {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
  ));
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
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    Response response = await _dio.post(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response;
  }
}
