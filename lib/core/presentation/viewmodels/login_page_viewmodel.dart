import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:product_app/core/presentation/states/login_page_state_provider.dart';
import 'package:product_app/features/product/presentation/pages/product_page.dart';
import 'package:product_app/features/product/presentation/viewmodels/product_viewmodel.dart';
import 'package:product_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:product_app/features/user/domain/entities/login.dart';

Logger logger = Logger();

class LoginPageViewmodel {
  final WidgetRef ref;
  final provider = loginPageStateNotifierProvider;
  final UserRepositoryImpl repository = UserRepositoryImpl();
  TextEditingController username = TextEditingController();
  TextEditingController senha = TextEditingController();

  LoginPageViewmodel(this.ref);

  void checkLogin() async {
    try {
      final token = await repository.getTokenCache();
      final user = await repository.getUserCache();
      logger.d([
        token,
        user,
      ]);
      final check = await repository.checkSession(token);
      if(check) {
        ref.read(provider.notifier).changeUser(user);
      }
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
    }
  }

  void reloadPage() async {
    try{
      logger.d("lmao get refreshed");
      ref.invalidate(provider);
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
    }
  }

  void syncControllers() {
    username = TextEditingController.fromValue(TextEditingValue(text: ref.read(provider).login.username));
    senha = TextEditingController.fromValue(TextEditingValue(text: ref.read(provider).login.password));
  }

  void updateControllers() {
    Login l = ref.read(provider).login.copyWith();
    logger.d(<dynamic>["antes", l.toString()]);
    if(username.value.text != l.username) {
      l = l.copyWith(username: username.value.text);
    }
    if(senha.value.text != l.password) {
      l = l.copyWith(password: senha.value.text);
    }
    logger.d(<dynamic>["depois", l.toString()]);
    ref.read(provider.notifier).changeLogin(l);
  }

  void reciclarLogin() {
    ref.read(provider.notifier).changeLogin(
      Login(
        username: "", 
        password: "",
      )
    );
  }

  void realizarLogin() async {
    updateControllers();
    ref.read(provider.notifier).changeLoading();
    try {
      final sessao = await repository.logIn(ref.read(provider).login);
      ref.read(provider.notifier).changeUser(sessao);
      reciclarLogin();
    } catch(e, stack) {
      logger.e(e, stackTrace: stack);
      reciclarLogin();
      ref.read(provider.notifier).changeError(e.toString());
      ref.read(provider.notifier).changeLoading();
    }
  }

  void navigateToProducts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProductPage(viewModel: ProductViewModel(ref))
      )
    );
  }
}