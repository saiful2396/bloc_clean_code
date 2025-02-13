import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc_clean_code/data/exception/app_exception.dart';
import 'package:bloc_clean_code/data/network/base_api_services.dart';

class NetworkServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(minutes: 1));

      jsonResponse = returnResponse(response);

      if (jsonResponse == 200) {}
    } on SocketException {
      throw NoInternetConnections();
    } on TimeoutException {
      throw RequestTimeOut();
    } on EmptyResponse {
      throw EmptyResponse();
    } on UnAuthorizeExceptions {
      throw UnAuthorizeExceptions();
    } on F5Exceptions {
      throw F5Exceptions();
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> postApi(String url, var data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(minutes: 1));

      jsonResponse = returnResponse(response);

      if (jsonResponse == 200) {}
    } on SocketException {
      throw NoInternetConnections();
    } on TimeoutException {
      throw RequestTimeOut();
    } on EmptyResponse {
      throw EmptyResponse();
    } on UnAuthorizeExceptions {
      throw UnAuthorizeExceptions();
    } on F5Exceptions {
      throw F5Exceptions();
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 401:
        throw UnAuthorizeExceptions(response.statusCode.toString());
      case 500:
        throw F5Exceptions(response.statusCode.toString());
        default:
          throw UnAuthorizeExceptions();
    }
  }
}
