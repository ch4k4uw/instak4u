// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/src/check_in/domain/repository/check_in_cmd_repository.dart'
    as _i14;
import 'package:domain/src/check_in/infra/remote/check_in_api.dart' as _i3;
import 'package:domain/src/check_in/infra/repository/check_in_cmd_repository_impl.dart'
    as _i15;
import 'package:domain/src/credential/domain/repository/user_cmd_repository.dart'
    as _i11;
import 'package:domain/src/credential/domain/repository/user_repository.dart'
    as _i13;
import 'package:domain/src/credential/infra/ioc/user_singleton_bind_module.dart'
    as _i16;
import 'package:domain/src/credential/infra/repository/user_cmd_repository_impl.dart'
    as _i12;
import 'package:domain/src/credential/infra/service/email_validator.dart'
    as _i5;
import 'package:domain/src/credential/infra/service/password_hashing.dart'
    as _i9;
import 'package:domain/src/credential/infra/service/user_storage.dart' as _i10;
import 'package:domain/src/feed/domain/repository/event_repository.dart' as _i7;
import 'package:domain/src/feed/infra/remote/event_api.dart' as _i6;
import 'package:domain/src/feed/infra/repository/event_repository_impl.dart'
    as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt $initDomainGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final userSingletonBindModule = _$UserSingletonBindModule();
    gh.singleton<_i3.CheckInApi>(_i3.CheckInApi(client: gh<_i4.Client>()));
    gh.singleton<_i5.EmailValidator>(_i5.EmailValidator());
    gh.singleton<_i6.EventApi>(_i6.EventApi(client: gh<_i4.Client>()));
    gh.singleton<_i7.EventRepository>(
        _i8.EventRepositoryImpl(api: gh<_i6.EventApi>()));
    gh.singleton<_i9.PasswordHashing>(_i9.PasswordHashing());
    gh.singleton<_i10.UserStorage>(_i10.UserStorage());
    gh.singleton<_i11.UserCmdRepository>(_i12.UserCmdRepositoryImpl(
        userStorage: gh<_i10.UserStorage>(),
        passwordHashing: gh<_i9.PasswordHashing>(),
        emailValidator: gh<_i5.EmailValidator>()));
    gh.singleton<_i13.UserRepository>(userSingletonBindModule
        .getUserRepository(gh<_i11.UserCmdRepository>()));
    gh.singleton<_i14.CheckInCmdRepository>(_i15.CheckInCmdRepositoryImpl(
        api: gh<_i3.CheckInApi>(), userRepository: gh<_i13.UserRepository>()));
    return this;
  }
}

class _$UserSingletonBindModule extends _i16.UserSingletonBindModule {}
