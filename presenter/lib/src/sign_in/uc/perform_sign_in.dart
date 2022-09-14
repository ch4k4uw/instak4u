import 'package:domain/credential.dart';

abstract class PerformSignIn {
  Future<User> call({required String email, required String password});
}