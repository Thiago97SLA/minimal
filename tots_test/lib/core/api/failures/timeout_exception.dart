import 'package:tots_test/core/error/failure.dart';

class TimeoutExceptionFailure extends Failure {
  const TimeoutExceptionFailure()
      : super(message: 'Ocurrio un error conectandonos a Veci');

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return message;
  }
}
