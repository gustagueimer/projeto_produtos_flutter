import 'package:product_app/features/user/domain/entities/login.dart';
import 'package:product_app/features/user/domain/entities/user.dart';

class LoginPageState { 
  final bool isLoading;
  final User? sessao;
  final Login login;
  final String? error;

  const LoginPageState({
    this.isLoading = false,
    this.sessao,
    required this.login,
    this.error,
  });

  LoginPageState copyWith({
    bool? isLoading,
    User? sessao,
    Login? login,
    String? error
  }) {
    return LoginPageState(
      isLoading: isLoading ?? this.isLoading,
      sessao: sessao ?? this.sessao,
      login: login ?? this.login,
      error: error ?? this.error,
    );
  }
}