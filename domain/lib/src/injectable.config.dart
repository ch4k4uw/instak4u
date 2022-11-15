// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import 'check_in/domain/repository/check_in_cmd_repository.dart' as _i14;
import 'check_in/infra/remote/check_in_api.dart' as _i3;
import 'check_in/infra/repository/check_in_cmd_repository_impl.dart' as _i15;
import 'credential/domain/repository/user_cmd_repository.dart' as _i11;
import 'credential/domain/repository/user_repository.dart' as _i13;
import 'credential/infra/ioc/user_singleton_bind_module.dart' as _i16;
import 'credential/infra/repository/user_cmd_repository_impl.dart' as _i12;
import 'credential/infra/service/email_validator.dart' as _i5;
import 'credential/infra/service/password_hashing.dart' as _i9;
import 'credential/infra/service/user_storage.dart' as _i10;
import 'feed/domain/repository/event_repository.dart' as _i7;
import 'feed/infra/remote/event_api.dart' as _i6;
import 'feed/infra/repository/event_repository_impl.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initDomainGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final userSingletonBindModule = _$UserSingletonBindModule();
  gh.singleton<_i3.CheckInApi>(_i3.CheckInApi(client: get<_i4.Client>()));
  gh.singleton<_i5.EmailValidator>(_i5.EmailValidator());
  gh.singleton<_i6.EventApi>(_i6.EventApi(client: get<_i4.Client>()));
  gh.singleton<_i7.EventRepository>(
      _i8.EventRepositoryImpl(api: get<_i6.EventApi>()));
  gh.singleton<_i9.PasswordHashing>(_i9.PasswordHashing());
  gh.singleton<_i10.UserStorage>(_i10.UserStorage());
  gh.singleton<_i11.UserCmdRepository>(_i12.UserCmdRepositoryImpl(
      userStorage: get<_i10.UserStorage>(),
      passwordHashing: get<_i9.PasswordHashing>(),
      emailValidator: get<_i5.EmailValidator>()));
  gh.singleton<_i13.UserRepository>(
      userSingletonBindModule.getUserRepository(get<_i11.UserCmdRepository>()));
  gh.singleton<_i14.CheckInCmdRepository>(_i15.CheckInCmdRepositoryImpl(
      api: get<_i3.CheckInApi>(), userRepository: get<_i13.UserRepository>()));
  return get;
}

class _$UserSingletonBindModule extends _i16.UserSingletonBindModule {}
