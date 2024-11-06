import 'package:tots_test/core/api/api_response.dart';
import 'package:tots_test/core/error/failure.dart';

class ApiFailure extends Failure {
  ApiFailure({required this.apiResponse, String? message})
      : super(
            message:
                message ?? apiResponse.errors?.first ?? 'Ha ocurrido un error');

  final ApiResponse apiResponse;
}
