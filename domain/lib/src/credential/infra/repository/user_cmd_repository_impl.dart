import 'package:core/common.dart';
import 'package:domain/src/credential/domain/data/app_invalid_email_exception.dart';
import 'package:domain/src/credential/domain/data/app_invalid_name_exception.dart';
import 'package:domain/src/credential/domain/entity/user.dart';
import 'package:domain/src/credential/domain/repository/user_cmd_repository.dart';
import 'package:domain/src/credential/infra/service/email_validator.dart';
import 'package:domain/src/credential/infra/service/password_hashing.dart';
import 'package:domain/src/credential/infra/service/user_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/data/app_duplicated_user_exception.dart';
import '../../domain/data/app_invalid_password_exception.dart';
import 'user_cmd_repository_constants.dart';

@singleton
class UserCmdRepositoryImpl implements UserCmdRepository {
  final UserStorage _userStorage;
  final PasswordHashing _passwordHashing;
  final EmailValidator _emailValidator;

  const UserCmdRepositoryImpl({
    required UserStorage userStorage,
    required PasswordHashing passwordHashing,
    required EmailValidator emailValidator,
  })  : _userStorage = userStorage,
        _passwordHashing = passwordHashing,
        _emailValidator = emailValidator;

  @override
  Future<User> findLogged() async {
    return await _userStorage.restore();
  }

  @override
  Future<void> logout() async {
    await _userStorage.remove();
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    final currUser = await _userStorage.findUserByEmail(email: email);
    final isValidUser = currUser != User.empty;
    final String currPass = await isValidUser.let((it) async {
      if (it) {
        return await _userStorage.findPasswordByEmail(email: email);
      }
      return "";
    });
    final isPasswordNotBlank = currPass.trim().isNotEmpty;
    final isValidPassword =
        isPasswordNotBlank && await _passwordHashing.compare(password, currPass);
    if (isValidPassword) {
      await _userStorage.store(user: currUser);
      return currUser;
    }
    return User.empty;
  }

  @override
  Future<User> signUp(User user, String password) async {
    _assertSignUpDataIntegrity(user: user, password: password);
    final newUser = user.copyWith(id: const Uuid().v4());
    await _userStorage.store(
      user: newUser,
      password: await _passwordHashing.hash(password: password),
    );
    return newUser;
  }

  void _assertSignUpDataIntegrity({
    required User user,
    required String password,
  }) {
    if (user.name.trim().isEmpty) {
      throw appInvalidNameException;
    }
    if (user.email.trim().isEmpty || !_isEmailValid(email: user.email)) {
      throw appInvalidEmailException;
    }
    if (password.length <= UserCmdRepositoryConstants.passwordLength) {
      throw appInvalidPasswordException;
    }
    _assertUserNotExists(user: user);
  }

  bool _isEmailValid({required String email}) {
    return _emailValidator.isValid(email: email);
  }

  Future<void> _assertUserNotExists({required User user}) async {
    final users = await _userStorage.findUsers();
    if (users.indexWhere((it) => it.email == user.email.toLowerCase()) != -1) {
      throw appDuplicatedUserException;
    }
  }
}
