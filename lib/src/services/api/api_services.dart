import 'package:dio/dio.dart';
import 'package:ecommerce_app/src/model/data.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> get(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    Response? response;
    try {
      _dio.options.baseUrl = AppData.baseUrl;
      response = await _dio.get(url,
          options: Options(headers: headers), queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
      return response!;
    }
  }

  Future<Response> post(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? body}) async {
    Response? response;
    try {
      _dio.options.baseUrl = AppData.baseUrl;
      response = await _dio.post(url,
          options: Options(headers: headers), data: body);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
      return response!;
    }
  }
}
