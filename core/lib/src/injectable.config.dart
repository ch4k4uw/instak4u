// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:core/src/common/view_model/future_runner.dart' as _i3;
import 'package:core/src/common/view_model/view_model_module.dart' as _i9;
import 'package:core/src/network/domain/service/http_client_factory.dart'
    as _i6;
import 'package:core/src/network/infra/injection/network_module.dart' as _i10;
import 'package:core/src/network/infra/service/http_client_factory_impl.dart'
    as _i7;
import 'package:core/src/network/infra/service/http_handler_factory.dart'
    as _i4;
import 'package:core/src/network/infra/service/http_logger_factory.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt $initCoreGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final viewModelModule = _$ViewModelModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i3.FutureRunner>(() => viewModelModule.getFutureRunner());
    gh.singleton<_i4.HttpHandlerFactory>(networkModule.getHttpHandlerFactory());
    gh.singleton<_i5.HttpLoggerFactory>(networkModule.getHttpLoggerFactory());
    gh.singleton<_i6.HttpClientFactory>(_i7.HttpClientFactoryImpl(
        loggerFactory: gh<_i5.HttpLoggerFactory>(),
        handlerFactory: gh<_i4.HttpHandlerFactory>()));
    gh.factory<_i8.Client>(() => networkModule.getHttpClient(
        clientFactory: gh<_i6.HttpClientFactory>()));
    return this;
  }
}

class _$ViewModelModule extends _i9.ViewModelModule {}

class _$NetworkModule extends _i10.NetworkModule {}
