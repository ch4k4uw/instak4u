import '../entity/user.dart';
import './user_repository.dart';

abstract class UserCmdRepository implements UserRepository {
  Future<User> signUp(User user, String password);
  Future<void> logout();
}