import 'package:injectable/injectable.dart';

import '../../domain/repository/user_cmd_repository.dart';
import '../../domain/repository/user_repository.dart';
import '../repository/user_cmd_repository_impl.dart';
import '../service/email_validator.dart';
import '../service/password_hashing.dart';
import '../service/user_storage.dart';

@module
abstract class UserSingletonBindModule {
  @singleton
  UserRepository getUserRepository(UserCmdRepository repository) => repository;
}
