import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio _dio;

  final Logger _logger = Logger();
  factory ApiService() {
    return _instance;
  }

  final box = GetStorage();

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://delivery-partner-backend.onrender.com/api/v1', // Replace with your API base URL
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> getItems({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params,
      options: Options(
        headers: {
          'Authorization':'Bearer ${box.read('token')}'
        }
      ));
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> postItem({
    required String endpoint,
    required dynamic data,
    isFormdata = false,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data,
          options: Options(
            contentType: isFormdata ? 'multipart/form-data' : 'application/json',
            headers: {
              'Authorization': 'Bearer ${box.read('token')}',
            },
          ));
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout. Please try again later.');
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout. Please try again later.');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout. Please try again later.');
      case DioExceptionType.badResponse:
        if (e.response != null && e.response!.statusCode != null) {
          return Exception('Server error: ${e.response!.statusCode}');
        }
        return Exception('Server error: Unknown status code');
      default:
        return Exception('Unexpected error: ${e.message}');
    }
  }
}
