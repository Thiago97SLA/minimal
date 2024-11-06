import 'package:tots_test/utils/logger.dart';

class ApiResponseErrorUtil {
  static List<String?> mapErrors(Map<String, dynamic>? response) {
    final List<String?> errors = [];
    try {
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        if (response['data']['error'] != null &&
            response['data']['error'] is String) {
          errors.add(response['data']['error'].toString());
        } else if (response['data']['message'] != null &&
            response['data']['message'] is String) {
          errors.add(response['data']['message'].toString());
        } else if (response['data']['errors'] != null) {
          if (response['data']['errors'] is List) {
            for (final error in response['data']['errors'] as List) {
              errors.add(error.toString());
            }
          } else if (response['data']['errors'] is Map &&
              response['data']['errors']['name'] is List) {
            for (final error in response['data']['errors']['name'] as List) {
              errors.add(error.toString());
            }
          }
        } else if (response['data']['error'] is Map) {
          final Map error = response['data']['error'] as Map;
          error.forEach((key, value) {
            errors.add('$key: $value');
          });
        }
      } else if (response['error'] != null) {
        if (response['error'] is String) {
          errors.add(response['error'] as String?);
        } else if (response['error'] is Map) {
          final Map error = response['error'] as Map;
          error.forEach((key, value) {
            errors.add('$key: $value');
          });
        }
      } else if (response['errors'] != null && response['errors'] is List) {
        for (final error in response['errors'] as List) {
          errors.add(error.toString());
        }
      }
    } catch (e, s) {
      CustomLogger.log('An error ocurred getting the errors');
      CustomLogger.logError(e.toString(), s.toString());
    }
    return errors;
  }
}
