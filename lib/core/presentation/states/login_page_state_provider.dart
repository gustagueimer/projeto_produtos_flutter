import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_app/core/presentation/states/login_page_state.dart';
import 'package:product_app/features/user/domain/entities/login.dart';
import 'package:product_app/features/user/domain/entities/user.dart';

class LoginPageStateNotifier extends Notifier<LoginPageState>{

  @override
  LoginPageState build() {
    return LoginPageState(login: Login(username: "", password: ""));
  }

  void changeLoading() {
    if(state.isLoading) {
      state = state.copyWith(isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true);
  }

  void changeError(String? error) {
    state = state.copyWith(error: error);
  }

  void changeLogin(Login login) {
    state = state.copyWith(login: login);
  }

  void changeUser(User? user) {
    state = state.copyWith(sessao: user);
  }
}

final loginPageStateNotifierProvider = NotifierProvider<LoginPageStateNotifier, LoginPageState>(() {
  return LoginPageStateNotifier();
});