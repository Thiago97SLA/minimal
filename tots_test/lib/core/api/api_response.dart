import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:tots_test/core/api/api_error.dart';
import 'package:tots_test/utils/logger.dart';

class ApiResponse extends Equatable {
  const ApiResponse({
    required this.headers,
    required this.rawResponse,
    required this.resource,
    required this.statusCode,
    this.logoutOn401 = true,
    this.body,
  });

  final String rawResponse;
  final String resource;
  final int statusCode;
  final Map<String, String> headers;
  final bool logoutOn401;
  final Map<String, dynamic>? body;

  dynamic get bodyJson => json.decode(rawResponse);

  Map<String, dynamic>? get responseMap {
    try {
      if (rawResponse.isEmpty || bodyJson is! Map) {
        return null;
      }
      return bodyJson as Map<String, dynamic>;
    } catch (e, s) {
      CustomLogger.logError('error on parsing response $e', s.toString());
      return null;
    }
  }

  List? get responseList {
    try {
      if (rawResponse.isEmpty || bodyJson is! List) {
        return null;
      }
      return bodyJson as List?;
    } catch (e, s) {
      CustomLogger.logError('error on parsing response $e', s.toString());
      return null;
    }
  }

  Future<T> responseToModel<T>(
      T Function(Map<String, dynamic>) converter) async {
    if (responseMap == null) {
      throw Exception('Response is not a Map');
    }
    return converter(responseMap!);
  }

  bool get isError => statusCode < 200 || statusCode >= 300;

  List<String?>? get errors =>
      isError ? ApiResponseErrorUtil.mapErrors(responseMap) : null;

  @override
  List<Object?> get props => [
        headers,
        rawResponse,
        resource,
        statusCode,
        logoutOn401,
        body,
      ];
}
