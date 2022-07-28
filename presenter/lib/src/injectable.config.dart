// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:core/common.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'sign_in/sign_in_view_model.dart' as _i3;
import 'sign_up/sign_up_view_model.dart' as _i5;
import 'splash/splash_screen_view_model.dart' as _i6;
import 'splash/splash_screen_view_model_params.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initPresenterGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.SignInViewModel>(
      () => _i3.SignInViewModelImpl(futureRunner: get<_i4.FutureRunner>()));
  gh.factory<_i5.SignUpViewModel>(
      () => _i5.SignUpViewModelImpl(futureRunner: get<_i4.FutureRunner>()));
  gh.factoryParam<_i6.SplashScreenViewModel, _i7.SplashScreenViewModelParams,
          _i4.FutureRunner?>(
      (params, futureRunner) => _i6.SplashScreenViewModelImpl(
          params: params, futureRunner: futureRunner));
  return get;
}
