import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tots_test/constant/api_constans.dart';

import 'package:tots_test/core/api/api_failure.dart';
import 'package:tots_test/core/api/api_response.dart';
import 'package:tots_test/core/api/failures/http_exception.dart';
import 'package:tots_test/core/api/failures/timeout_exception.dart';
import 'package:tots_test/core/api/token/token_provider.dart';
import 'package:tots_test/utils/logger.dart';

final requestHandlerProvider = Provider<RequestHandler>((ref) {
  return RequestHandlerImpl(ref: ref);
});

abstract class RequestHandler {
  /// Perform **GET** to the api.
  ///
  /// Throws [ApiFailure] if the response contain an error.
  /// Throws [Exception] if the request fails in client.
  Future<ApiResponse> performGet(
    String path, {
    bool withJwtToken = true,
  });

  /// Perform **POST** to the api.
  ///
  /// Throws [ApiFailure] if the response contain an error.
  /// Throws [Exception] if the request fails in client.
  Future<ApiResponse> performPost(
    String path,
    Map<String, dynamic> body, {
    bool withJwtToken = true,
    bool ignoreErrors = false,
  });

  /// Perform **PUT** to the api.
  ///
  /// Throws [ApiFailure] if the response contain an error.
  /// Throws [Exception] if the request fails in client.
  Future<ApiResponse> performPut(
    String path,
    Map<String, dynamic> body, {
    bool withJwtToken = true,
  });

  /// Perform **DELETE** to the api.
  ///
  /// Throws [ApiFailure] if the response contain an error.
  /// Throws [Exception] if the request fails in client.
  Future<ApiResponse> performDelete(
    String path, {
    bool withJwtToken = true,
  });

  void printApiResponse({
    required String method,
    required String path,
    required int statusCode,
    required String? token,
    Map? headers,
    Map? body,
    Object? responseMap,
    Object? responseList,
  }) {}
}

class RequestHandlerImpl implements RequestHandler {
  RequestHandlerImpl({required this.ref});

  static const _timeoutDuration = Duration(seconds: 60);

  final Ref ref;

  @override
  Future<ApiResponse> performGet(
    String path, {
    bool withJwtToken = true,
  }) async {
    try {
      final headers = await getHeaders(withToken: withJwtToken);
      final res = await http
          .get(
            _uriFromPath(path),
            headers: headers,
          )
          .timeout(_timeoutDuration);
      final ApiResponse apiResponse = ApiResponse(
        statusCode: res.statusCode,
        rawResponse: res.body.trim(),
        resource: _uriFromPath(path).toString(),
        headers: headers,
      );
      CustomLogger.log(
          '==================================================================');
      CustomLogger.log('Finished: Response for [GET] to $path: ');
      printApiResponse(
        method: 'GET',
        path: path,
        statusCode: apiResponse.statusCode,
        responseMap: apiResponse.responseMap,
        responseList: apiResponse.responseList,
        headers: headers,
        token: withJwtToken ? headers['Authorization'] : 'NO TOKEN',
      );
      if (apiResponse.isError) {
        throw ApiFailure(apiResponse: apiResponse);
      }
      return apiResponse;
    } on TimeoutException catch (_) {
      throw const TimeoutExceptionFailure();
    } on HttpException catch (_) {
      throw const HttpExceptionFailure();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> performPost(
    String path,
    Map<String, dynamic> body, {
    bool withJwtToken = true,
    bool logoutOn401 = true,
    bool ignoreErrors = false,
  }) async {
    try {
      final headers = await getHeaders(withToken: withJwtToken);
      final res = await http
          .post(
            _uriFromPath(path),
            headers: headers,
            body: utf8.encode(json.encode(body)),
          )
          .timeout(_timeoutDuration);
      final ApiResponse apiResponse = ApiResponse(
        statusCode: res.statusCode,
        rawResponse: res.body.trim(),
        logoutOn401: logoutOn401,
        resource: _uriFromPath(path).toString(),
        headers: headers,
        body: body,
      );
      CustomLogger.log(
          '==================================================================');
      CustomLogger.log('Finished: Response for [POST] to $path: ');
      printApiResponse(
        method: 'POST',
        path: path,
        statusCode: apiResponse.statusCode,
        responseMap: apiResponse.responseMap,
        body: body,
        headers: headers,
        token: withJwtToken ? headers['Authorization'] : 'NO TOKEN',
      );
      if (apiResponse.isError && !ignoreErrors) {
        throw ApiFailure(apiResponse: apiResponse);
      }
      return apiResponse;
    } on TimeoutException catch (_) {
      throw const TimeoutExceptionFailure();
    } on HttpException catch (_) {
      throw const HttpExceptionFailure();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> performPut(
    String path,
    Map<String, dynamic> body, {
    bool withJwtToken = true,
    bool logoutOn401 = true,
  }) async {
    try {
      final headers = await getHeaders(withToken: withJwtToken);
      final res = await http
          .put(
            _uriFromPath(path),
            headers: headers,
            body: utf8.encode(json.encode(body)),
          )
          .timeout(_timeoutDuration);
      final ApiResponse apiResponse = ApiResponse(
        statusCode: res.statusCode,
        rawResponse: res.body.trim(),
        resource: _uriFromPath(path).toString(),
        logoutOn401: logoutOn401,
        headers: headers,
        body: body,
      );
      CustomLogger.log(
          '==================================================================');
      CustomLogger.log('Finished: Response for [PUT] to $path: ');
      printApiResponse(
        method: 'PUT',
        path: path,
        statusCode: apiResponse.statusCode,
        responseMap: apiResponse.responseMap,
        body: body,
        headers: headers,
        token: withJwtToken ? headers['Authorization'] : 'NO TOKEN',
      );
      if (apiResponse.isError) {
        throw ApiFailure(apiResponse: apiResponse);
      }
      return apiResponse;
    } on TimeoutException catch (_) {
      throw const TimeoutExceptionFailure();
    } on HttpException catch (_) {
      throw const HttpExceptionFailure();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> performDelete(
    String path, {
    bool withJwtToken = true,
    bool logoutOn401 = true,
  }) async {
    try {
      final headers = await getHeaders(withToken: withJwtToken);
      final res = await http
          .delete(
            _uriFromPath(path),
            headers: headers,
          )
          .timeout(_timeoutDuration);
      final ApiResponse apiResponse = ApiResponse(
        statusCode: res.statusCode,
        rawResponse: res.body.trim(),
        resource: _uriFromPath(path).toString(),
        logoutOn401: logoutOn401,
        headers: headers,
      );
      CustomLogger.log(
          '==================================================================');
      CustomLogger.log('Finished: Response for [DELETE] to $path: ');
      printApiResponse(
        method: 'DELETE',
        path: path,
        statusCode: apiResponse.statusCode,
        responseMap: apiResponse.responseMap,
        headers: headers,
        token: withJwtToken ? headers['Authorization'] : 'NO TOKEN',
      );
      if (apiResponse.isError) {
        throw ApiFailure(apiResponse: apiResponse);
      }
      return apiResponse;
    } on TimeoutException catch (_) {
      throw const TimeoutExceptionFailure();
    } on HttpException catch (_) {
      throw const HttpExceptionFailure();
    } catch (_) {
      rethrow;
    }
  }

  @override
  void printApiResponse({
    required String method,
    required String path,
    required int statusCode,
    required String? token,
    Map? headers,
    Map? body,
    Object? responseMap,
    Object? responseList,
  }) {
    const logger = CustomLogger.log;
    logger('Status Code [$statusCode]');
    logger('Token: $token');
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    logger('Headers: ${encoder.convert(headers)}');
    if (body != null) {
      try {
        final String prettyBody = encoder.convert(body);
        logger('\nBody: ');
        logger('$prettyBody\n');
      } catch (e) {
        logger('error on formatting response');
      }
    }
    if (responseMap != null) {
      try {
        final String prettyResponseMap = encoder.convert(responseMap);
        logger('\nJSON Response: ');
        logger(prettyResponseMap);
      } catch (e) {
        logger('error on formatting response');
      }
    }
    if (responseList != null) {
      try {
        final String prettyResponseMap = encoder.convert(responseList);
        logger('\nJSON Response: ');
        logger(prettyResponseMap);
      } catch (e) {
        logger('error on formatting response');
      }
    }
    logger(
        '==================================================================');
  }

  Uri _uriFromPath(String path) {
    return Uri.parse('${ApiConstants.apiPath}$path');
  }

  Future<Map<String, String>> getHeaders({required bool withToken}) async {
    final Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    if (withToken) {
      headers['Authorization'] =
          await ref.read(tokenUtilsProvider).getToken() ?? '';
    }
    return headers;
  }
}
