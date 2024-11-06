import 'package:equatable/equatable.dart';

class ClientModel extends Equatable {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? address;
  final String? createdAt;
  final String? updatedAt;
  final int? userId;
  final String? photo;

  const ClientModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.photo});

  ClientModel copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? address,
    String? createdAt,
    String? updatedAt,
    int? userId,
    String? photo,
  }) =>
      ClientModel(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        address: address ?? this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        photo: photo ?? this.photo,
      );

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        firstname: json['firstname'].toString(),
        lastname: json['lastname'].toString(),
        email: json['email'].toString(),
        address: json['address'].toString(),
        createdAt: json['created_at'].toString(),
        updatedAt: json['updated_at'].toString(),
        userId: json['user_id'] != null
            ? int.tryParse(json['user_id'].toString())
            : null,
        photo: json['photo'].toString(),
      );

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        email,
        address,
        createdAt,
        updatedAt,
        userId,
        photo,
      ];
}
