import '../models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> getUser();
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserModel user);
  Future<void> logout();
}