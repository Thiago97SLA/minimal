import 'package:tots_test/core/error/failure.dart';

class HttpExceptionFailure extends Failure {
  const HttpExceptionFailure() : super(message: 'Ha ocurrido un error');

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return message;
  }
}
