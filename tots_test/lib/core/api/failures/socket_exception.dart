import 'package:tots_test/core/error/failure.dart';

class SocketExceptionFailure extends Failure {
  const SocketExceptionFailure()
      : super(message: 'Revisa tu conexión a internet');

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return message;
  }
}
