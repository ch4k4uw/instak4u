// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'credential/domain/repository/user_cmd_repository.dart' as _i6;
import 'credential/domain/repository/user_repository.dart' as _i8;
import 'credential/infra/ioc/user_singleton_bind_module.dart' as _i9;
import 'credential/infra/repository/user_cmd_repository_impl.dart' as _i7;
import 'credential/infra/service/email_validator.dart' as _i3;
import 'credential/infra/service/password_hashing.dart' as _i4;
import 'credential/infra/service/user_storage.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initDomainGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final userSingletonBindModule = _$UserSingletonBindModule();
  gh.singleton<_i3.EmailValidator>(_i3.EmailValidator());
  gh.singleton<_i4.PasswordHashing>(_i4.PasswordHashing());
  gh.singleton<_i5.UserStorage>(_i5.UserStorage());
  gh.singleton<_i6.UserCmdRepository>(
      userSingletonBindModule.getUserCmdRepository(
          userStorage: get<_i5.UserStorage>(),
          passwordHashing: get<_i4.PasswordHashing>(),
          emailValidator: get<_i3.EmailValidator>()));
  gh.singleton<_i7.UserCmdRepositoryImpl>(_i7.UserCmdRepositoryImpl(
      userStorage: get<_i5.UserStorage>(),
      passwordHashing: get<_i4.PasswordHashing>(),
      emailValidator: get<_i3.EmailValidator>()));
  gh.singleton<_i8.UserRepository>(
      userSingletonBindModule.getUserRepository(get<_i6.UserCmdRepository>()));
  return get;
}

class _$UserSingletonBindModule extends _i9.UserSingletonBindModule {}
