import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_clean_code/data/exception/app_exception.dart';
import 'package:bloc_clean_code/data/network/base_api_services.dart';

class NetworkServices extends BaseApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await _dio.get(url);

      if (kDebugMode) {
        print('Response: ${response.data}');
      }

      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } on SocketException {
      throw NoInternetConnections();
    } on TimeoutException {
      throw RequestTimeOut();
    }
  }

  @override
  Future<dynamic> postApi(String url, var data) async {
    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Body: $data');
      }

      final response = await _dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'x-api-key': 'reqres-free-v1',
          },
        ),
      );

      if (kDebugMode) {
        print('Response Body: ${response.data}');
      }

      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } on SocketException {
      throw NoInternetConnections(
        'Please check your internet connection and try again!',
      );
    } on TimeoutException {
      throw RequestTimeOut('');
    }
  }

  /// Dio centralized error handling
  Never _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response?.statusCode;

      switch (statusCode) {
        case 400:
          throw EmptyResponse(error.response?.data.toString());
        case 401:
          throw UnAuthorizeExceptions(statusCode.toString());
        case 500:
          throw F5Exceptions(statusCode.toString());
        default:
          throw UnAuthorizeExceptions();
      }
    } else {
      // No response = network error
      throw NoInternetConnections();
    }
  }
}

