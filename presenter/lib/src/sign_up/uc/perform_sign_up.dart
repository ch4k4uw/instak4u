import 'package:domain/credential.dart';

abstract class PerformSignUp {
  Future<User> call({
    required String name,
    required String email,
    required String password,
  });
}
