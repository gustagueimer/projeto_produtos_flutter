class Login {
  final String username;
  final String password;
  final int? expiresInMins;

  Login({
    required this.username,
    required this.password,
    this.expiresInMins
  });

  Login copyWith({
    String? username,
    String? password,
    int? expiresInMins,
  }) {
    return Login(
      username: username ?? this.username,
      password: password ?? this.password,
      expiresInMins: expiresInMins
    );
  }

  @override
  String toString() {
    return "Login(username: $username, password: $password, expiresInMins: $expiresInMins)";
  }
}