class LoginModel {
  final String username;
  final String password;
  final int? expiresInMins;

  LoginModel({
    required this.username,
    required this.password,
    this.expiresInMins
  });

  Map<String, dynamic> toJson() {
    return  {
      "username": username,
      "password": password,
      "expiresInMins": expiresInMins ?? 60,
    };
  }

  @override
  String toString() {
    return "LoginModel(username: $username, password: $password, expiresInMins: $expiresInMins)";
  }
}