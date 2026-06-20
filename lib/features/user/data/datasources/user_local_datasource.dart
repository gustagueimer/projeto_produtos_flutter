import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:product_app/features/user/data/models/user_model.dart';
import 'package:product_app/features/user/data/datasources/user_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

Logger logger = Logger();

class UserLocalDatasource implements UserDatasource {

  UserLocalDatasource();

  Future<void> saveToken(String token) async {
    logger.d("start save token");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.setString('token', token);
    logger.d("end save token");
  }

  Future<String> retrieveToken() async {
    logger.d("start retireve token");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    final token = cache.getString('token');

    if(token == null) {
      throw Exception("Não há token salvo no cache");
    }

    logger.d("end retrieve token");

    return token; 
  }

  Future<bool> removeToken() async {
    logger.d("start remove token");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    logger.d("end remove token");
    return await cache.remove('token');
  }

  Future<void> saveUser(UserModel user) async {
    logger.d("start save user");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.setString('currentUser', jsonEncode(user.toJson()));
    logger.d("end save user");
  }

  Future<bool> removeUser() async {
    logger.d("start remove user");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    logger.d("end remove user");
    return await cache.remove('currentuser');
  }

  Future<void> saveSessionMinDuration(int durationTimeInMin) async {
    logger.d("start save session duration");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.setInt('SessionMinDuration', durationTimeInMin);
    logger.d("end save session duration");
  }

  Future<int> retrieveSessionMinDuration() async {
    logger.d("start retrieve session duration");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    final sessionMinDuration = cache.getInt('SessionMinDuration');

    if(sessionMinDuration == null) {
      throw Exception("não há registro do tempo de duração da ultima sessão no cache");
    }

    logger.d("end retrieve session duration");

    return sessionMinDuration;
  }

  Future<void> saveLastLoginDate(DateTime lastLoginDate) async {
    logger.d("start save login date");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.setString('lastLoginDate', lastLoginDate.toIso8601String());
    logger.d("end save login date");
  }

  Future<DateTime> retrieveLastLoginDate() async {
    logger.d("start retireve login date");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    final lastLoginDate = cache.getString('lastLoginDate');

    if(lastLoginDate == null) {
      throw Exception("não há registro da data do ultimo login no cache");
    }

    logger.d("end retrieve login date");

    return DateTime.parse(lastLoginDate);
  }

  @override
  Future<UserModel> getMe() async {
    logger.d("start get user");
    final SharedPreferences cache = await SharedPreferences.getInstance();
    final String? user = cache.getString('currentUser');
    
    if(user == null) {
      throw Exception("não há usuário salvo no app");
    }

    logger.d("end get user");

    return UserModel.fromJson(jsonDecode(user));
  }

}