import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/config/config.dart';
import 'package:flutter_antonx_boilerplate/core/models/responses/base_responses/request_response.dart';
import 'package:flutter_antonx_boilerplate/core/services/local_storage_service.dart';

import '../../locator.dart';

class ApiServices {
  final config = locator<Config>();
  Future<Dio> launchDio() async {
    String? accessToken = locator<LocalStorageService>().accessToken;
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // dio.interceptors.add(
    //     DioCacheManager(CacheConfig(baseUrl: EndPoint.baseUrl)).interceptor);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    dio.options.headers["Authorization"] = 'Bearer $accessToken';

    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      if (s != null) {
        return s < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  get({required String endPoint, params}) async {
    Dio dio = await launchDio();
    final response = await dio
        .get('${config.baseUrl}/$endPoint', queryParameters: params)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }

  post({required String endPoint, data}) async {
    Dio dio = await launchDio();
    final response = await dio
        .post('${config.baseUrl}/$endPoint', data: data)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }

  put({required String endPoint, data}) async {
    Dio dio = await launchDio();
    final response = await dio
        .put('${config.baseUrl}/$endPoint', data: data)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }

  delete({required String endPoint, params}) async {
    Dio dio = await launchDio();
    final response = await dio
        .delete('${config.baseUrl}/$endPoint', queryParameters: params)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }
}
