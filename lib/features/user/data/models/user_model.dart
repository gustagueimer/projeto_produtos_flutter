import 'package:product_app/features/user/domain/entities/user.dart';

class UserModel implements User {
  @override final int id;
  @override final String email;
  @override final String username;
  @override final String firstName;
  @override final String lastName;
  @override final String gender;
  @override final String image;
  @override final String accessToken;
  @override final String refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  UserModel copyWith({
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      id: id, 
      email: email ?? this.email, 
      username: username ?? this.username, 
      firstName: firstName ?? this.firstName, 
      lastName: lastName ?? this.lastName, 
      gender: gender ?? this.gender, 
      image: image ?? this.image, 
      accessToken: accessToken ?? this.accessToken, 
      refreshToken: refreshToken ??this.refreshToken
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "image": image,
      "accessToken": accessToken,
      "refreshToken": refreshToken
    };
  }

  @override
  String toString() {
    return """User(
      id: $id,
      username: $username,
      email: $email,
      firstName: $firstName,
      lastName: $lastName,
      gender: $gender,
      image: $image,
      accessToken: $accessToken,
      refreshToken: $refreshToken,
      )""";
  }
}