import '../entity/user.dart';

abstract class UserRepository {
  Future<User> findLogged();
  Future<User> signIn({required String email, required String password});
}