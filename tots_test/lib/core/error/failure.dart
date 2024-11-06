import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  static Future<Failure?> fromFunction(
    Future<void> Function() future, {
    bool throwException = false,
  }) async {
    try {
      await future();
      return null;
    } catch (e) {
      if (throwException) rethrow;
      return Failure(message: e.toString());
    }
  }

  static Future<Failure?> fromFuture(
    Future<void> future, {
    bool throwException = false,
  }) async {
    try {
      await future;
      return null;
    } catch (e) {
      if (throwException) rethrow;
      return Failure(message: e.toString());
    }
  }

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}
