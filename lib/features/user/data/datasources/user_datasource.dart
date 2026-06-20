import 'package:product_app/features/user/data/models/user_model.dart';

abstract class UserDatasource {
  Future<UserModel> getMe();
}