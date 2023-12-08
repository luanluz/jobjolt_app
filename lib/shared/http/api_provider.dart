// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'package:jobjolt/feature/auth/repository/token_repository.dart';
import 'package:jobjolt/shared/http/api_response.dart';
import 'package:jobjolt/shared/http/app_exception.dart';
import 'package:jobjolt/shared/http/interceptor/dio_connectivity_request_retrier.dart';
import 'package:jobjolt/shared/http/interceptor/retry_interceptor.dart';

enum ContentType { urlEncoded, json }

final apiProvider = Provider<ApiProvider>(ApiProvider.new);

class ApiProvider {
  ApiProvider(this._ref) {
    _initializeDio();
    _initializeBaseUrl();
  }

  final Ref _ref;
  late Dio _dio;
  late final TokenRepository _tokenRepository = _ref.read(tokenRepositoryProvider);
  late String _baseUrl;

  void _initializeDio() {
    _dio = Dio();
    _dio.options.sendTimeout = const Duration(seconds: 5);
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(requestBody: true));
    }
  }

  void _initializeBaseUrl() {
    _baseUrl = dotenv.env['BASE_URL'] ?? '';
  }

  Future<APIResponse> _handleRequest(String method, String path, {
    String? newBaseUrl,
    String? token,
    dynamic body,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json
  }) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return APIResponse.error(AppException.connectivity('there_is_no_internet_connection'.tr()));
    }

    String url = newBaseUrl ?? _baseUrl;
    url += path;

    var content = contentType == ContentType.json
        ? 'application/json'
        : 'application/x-www-form-urlencoded';

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    final appToken = await _tokenRepository.fetchToken();

    if (appToken != null) {
      headers['Authorization'] = 'Bearer $appToken';
    }

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      late Response response;

      switch (method) {
        case 'get':
          response = await _dio.get(
            url,
            queryParameters: query,
            options: Options(validateStatus: (status) => true, headers: headers),
          );
          break;
        case 'post':
          response = await _dio.post(
            url,
            data: body,
            queryParameters: query,
            options: Options(validateStatus: (status) => true, headers: headers),
          );
          break;
        case 'put':
          response = await _dio.put(
            url,
            data: body,
            queryParameters: query,
            options: Options(validateStatus: (status) => true, headers: headers),
          );
          break;
        case 'patch':
          response = await _dio.patch(
            url,
            data: body,
            queryParameters: query,
            options: Options(validateStatus: (status) => true, headers: headers),
          );
          break;
        case 'delete':
          response = await _dio.delete(
            url,
            queryParameters: query,
            options: Options(validateStatus: (status) => true, headers: headers),
          );
          break;
        default:
          return APIResponse.error(AppException.error('invalid_http_method'.tr()));
      }

      if (response.statusCode == null) {
        return APIResponse.error(AppException.connectivity('unknown_error'.tr()));
      }

      if (response.statusCode! < 300) {
        return APIResponse.success(response.data['data'] ?? response.data);
      }

      return _handleError(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return APIResponse
          .error(AppException.errorWithMessage(e.toString()));
    }
  }

  APIResponse _handleError(Response response) {
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 400:
        final effectiveMessage = StringBuffer();
        final message = response.data['message'];
        final params = response.data['params'] as Map<String, dynamic>?;

        effectiveMessage.write('$message\n');

        if (params != null) {
          effectiveMessage.writeAll(
            params.entries.map((e) => '${e.key}: ${e.value}\n')
          );
        }

        return APIResponse.error(AppException.connectivity(effectiveMessage.toString()));
      case 404:
        return APIResponse.error(AppException.connectivity(response.data['message']));
      case 401:
        return APIResponse.error(AppException.unauthorized(response.data['message']));
      case 502:
        return APIResponse.error(AppException.error(response.data['message']));
      default:
        if (response.data['message'] != null) {
          return APIResponse.error(AppException.errorWithMessage(response.data['message']));
        }

        return APIResponse.error(AppException.error('unknown_error'.tr()));
    }
  }

  APIResponse _handleDioError(DioException e) {
    if (e.error is SocketException) {
      return APIResponse.error(AppException.connectivity(e.message));
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return APIResponse.error(AppException.connectivity(e.message));
    }

    if (e.response != null) {
      if (e.response!.data['message'] != null) {
        return APIResponse
            .error(AppException.errorWithMessage(e.response!.data['message']));
      }
    }

    return APIResponse
        .error(AppException.errorWithMessage(e.message ?? ''));
  }

  Future<APIResponse> post(String path, dynamic body, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async {
    return await _handleRequest(
        'post',
        path,
        newBaseUrl: newBaseUrl,
        token: token,
        body: body,
        query: query,
        contentType: contentType
    );
  }

  Future<APIResponse> get(String path, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async =>
      await _handleRequest(
          'get',
          path,
          newBaseUrl: newBaseUrl,
          token: token,
          query: query,
          contentType: contentType
      );

  Future<APIResponse> put(String path, dynamic body, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async =>
      await _handleRequest(
          'put',
          path,
          newBaseUrl: newBaseUrl,
          token: token,
          body: body,
          query: query,
          contentType: contentType
      );

  Future<APIResponse> patch(String path, dynamic body, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async =>
      await _handleRequest(
          'patch',
          path,
          newBaseUrl: newBaseUrl,
          token: token,
          body: body,
          query: query,
          contentType: contentType
      );

  Future<APIResponse> delete(String path, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async =>
      await _handleRequest(
          'delete',
          path,
          newBaseUrl: newBaseUrl,
          token: token,
          query: query,
          contentType: contentType
      );
}
