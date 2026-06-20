import 'package:product_app/features/user/data/models/user_model.dart';
import 'package:product_app/features/user/domain/entities/login.dart';
import 'package:product_app/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> saveTokenCache(String token);
  Future<void> saveUserCache(UserModel user);
  Future<String> getTokenCache(); 
  Future<User> getUserCache();
  Future<void> deleteTokenCache();
  Future<void> deleteUserCache();
  Future<User?> getUser();
  Future<User> logIn(Login login);
  Future<bool> checkSession(String token);
}