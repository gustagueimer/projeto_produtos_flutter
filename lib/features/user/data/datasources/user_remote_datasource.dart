import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:product_app/core/errors/faliure.dart';
import 'package:product_app/features/user/data/datasources/user_datasource.dart';
import 'package:product_app/features/user/data/models/user_model.dart';
import 'package:product_app/features/user/data/models/login_model.dart';
import 'package:http/http.dart';

Logger logger = Logger();

class UserRemoteDatasource extends UserDatasource{
  final Client client = Client();
  final String baseLink = "https://dummyjson.com/auth";
  String? token;

  UserRemoteDatasource({this.token});

  void setToken(String token) {
    this.token  = token;
  }

  Map<String, String> headerBuilder() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    token != null ? headers['Authorization'] = 'Bearer /* YOUR_ACCESS_TOKEN_HERE */' : logger.d("no token lmao");
    return headers; 
  }

  Future<UserModel> logIn(LoginModel login) async {
    final composedLink = "/login";
    final response = await client.post(
      Uri.parse("$baseLink$composedLink"),
      headers: headerBuilder(),
      body: jsonEncode(login.toJson()),
    );

    if(response.statusCode != 200 && response.statusCode != 400) {
      logger.d(response.statusCode);
      throw Exception("erro no login :P");
    }

    if(response.statusCode == 400) {
      logger.d(response.statusCode);
      throw Failure("dados inválidos :P");
    }

    return UserModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<UserModel> getMe() async {
    final composedLink = "/me";
    logger.d(Uri.parse("$baseLink$composedLink"));

    final response = await client.get(
      Uri.parse("$baseLink$composedLink"),
      headers: headerBuilder(),
    );

    if(response.statusCode != 200) {
      logger.d(response.statusCode);
      throw Exception("erro ao buscar informações do usuário :P ");
    }

    return UserModel.fromJson(jsonDecode(response.body));
  }
}