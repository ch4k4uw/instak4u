import 'package:domain/credential.dart';

abstract class FindLoggedUser {
  Future<User> call();
}