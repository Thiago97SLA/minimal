import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.email,
    this.tokenType,
    this.accessToken,
  });

  final int? id;
  final String? accessToken;
  final String? tokenType;
  final String? email;

  User copyWith({
    String? accessToken,
    String? tokenType,
    String? email,
  }) {
    return User(
      id: id ?? id,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      email: email ?? this.email,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        accessToken: json['access_token'].toString(),
        tokenType: json['token_type'].toString(),
        email: json['email'].toString(),
      );

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        email,
      ];
}
