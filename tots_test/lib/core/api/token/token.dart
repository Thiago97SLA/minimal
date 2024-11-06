import 'package:equatable/equatable.dart';

class Token extends Equatable {
  const Token({required this.token, DateTime? expirationDate});

  final String? token;

  String get bearerToken => 'Bearer $token';

  @override
  List<Object?> get props => [
        token,
      ];
}
