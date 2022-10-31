// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import 'credential/domain/repository/user_cmd_repository.dart' as _i10;
import 'credential/domain/repository/user_repository.dart' as _i12;
import 'credential/infra/ioc/user_singleton_bind_module.dart' as _i13;
import 'credential/infra/repository/user_cmd_repository_impl.dart' as _i11;
import 'credential/infra/service/email_validator.dart' as _i3;
import 'credential/infra/service/password_hashing.dart' as _i8;
import 'credential/infra/service/user_storage.dart' as _i9;
import 'feed/domain/repository/event_repository.dart' as _i6;
import 'feed/infra/remote/event_api.dart' as _i4;
import 'feed/infra/repository/event_repository_impl.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initDomainGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final userSingletonBindModule = _$UserSingletonBindModule();
  gh.singleton<_i3.EmailValidator>(_i3.EmailValidator());
  gh.singleton<_i4.EventApi>(_i4.EventApi(client: get<_i5.Client>()));
  gh.singleton<_i6.EventRepository>(
      _i7.EventRepositoryImpl(api: get<_i4.EventApi>()));
  gh.singleton<_i8.PasswordHashing>(_i8.PasswordHashing());
  gh.singleton<_i9.UserStorage>(_i9.UserStorage());
  gh.singleton<_i10.UserCmdRepository>(_i11.UserCmdRepositoryImpl(
      userStorage: get<_i9.UserStorage>(),
      passwordHashing: get<_i8.PasswordHashing>(),
      emailValidator: get<_i3.EmailValidator>()));
  gh.singleton<_i12.UserRepository>(
      userSingletonBindModule.getUserRepository(get<_i10.UserCmdRepository>()));
  return get;
}

class _$UserSingletonBindModule extends _i13.UserSingletonBindModule {}
