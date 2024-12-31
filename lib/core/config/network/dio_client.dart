import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:popular_movies/core/exceptions/exceptions.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _initializeInterceptors();
  }

  // Método para realizar GET requests
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      log(" Response of get ::${response.statusCode}");
      return _handleResponse(response);
    } on DioException catch (e) {
      log("CATCH");
      return _handleError(e);
    }
  }

  // Método para realizar POST requests
  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Métodos similares para PUT, DELETE, etc.

  // Inicializar interceptores
  void _initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Añadir headers, tokens, etc.
        options.headers['Accept'] = 'application/json';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Logging, transformaciones
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        log("EEEEEE $e  $handler");
        // Manejo de errores globale
        return handler.next(e);
      },
    ));

    // Añadir logger interceptor para depuración
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  // Manejo de respuestas
  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
        throw UnauthorizedException(response.data.toString());
      case 403:
        throw ForbiddenException(response.data.toString());
      case 404:
        throw NotFoundException(response.data.toString());
      case 500:
        throw InternalServerErrorException(response.data.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

  // Manejo de errores
  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw FetchDataException('Connection Timeout');
      case DioExceptionType.receiveTimeout:
        throw FetchDataException('Receive Timeout');
      case DioExceptionType.badResponse:
        return _handleResponse(error.response!);
      case DioExceptionType.cancel:
        throw FetchDataException('Request Cancelled');
      case DioExceptionType.unknown:
        throw FetchDataException('Error Sending Request');
      default:
        throw FetchDataException('Unexpected Error');
    }
  }
}


//  options.headers = {
//       'api-x-key': 'tu-api-key-aqui',
//       'Authorization': 'Bearer tu-token-aqui',
//       ...?options.headers, // Mantener encabezados adicionales existentes
//     };