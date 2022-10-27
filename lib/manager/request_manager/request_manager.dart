import 'package:dio/dio.dart';
import 'package:frontend/enums/request_type.dart';
import 'package:frontend/manager/request_manager/interceptor/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RequestManager {
  late final Dio _dio;
  RequestManager(String baseUrl) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    _dio.interceptors.add(PrettyDioLogger(responseBody: true));
    _dio.interceptors.add(TokenInterceptor());
  }
  Future<List<T>?> getList<T>({
    required String path,
    required RequestType requestType,
    required T Function(Map<String, dynamic> json) converter,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      Response? response;
      switch (requestType) {
        case RequestType.GET:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
          );
          break;
        case RequestType.POST:
          response = await _dio.post(
            path,
            queryParameters: queryParameters,
            data: body,
          );
          break;
        case RequestType.PUT:
          response = await _dio.put(
            path,
            queryParameters: queryParameters,
            data: body,
          );
          break;
        default:
      }

      var data = response?.data as List?;

      if (data == null) {
        return null;
      }

      return data.map((e) => converter(e)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<T?> getSingle<T>({
    required String path,
    required RequestType requestType,
    required T Function(Map<String, dynamic> json) converter,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    try {
      Response? response;
      switch (requestType) {
        case RequestType.GET:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
          );
          break;
        case RequestType.POST:
          response = await _dio.post(
            path,
            queryParameters: queryParameters,
            data: body,
          );
          break;
        case RequestType.PUT:
          response = await _dio.put(
            path,
            queryParameters: queryParameters,
            data: body,
          );
          break;
        default:
      }

      var data = response?.data;

      if (data == null) {
        return null;
      }

      T model = converter(data);

      return model;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> getResult({
    required String path,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      Response? response;
      switch (requestType) {
        case RequestType.GET:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
          );
          break;
        case RequestType.POST:
          response = await _dio.post(
            path,
            queryParameters: queryParameters,
            data: body,
          );
          break;
        case RequestType.PUT:
          response = await _dio.put(
            path,
            queryParameters: queryParameters,
            data: body,
          );
          break;
        default:
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
