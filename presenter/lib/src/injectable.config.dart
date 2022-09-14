// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:core/common.dart' as _i11;
import 'package:domain/credential.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'common/us/find_logged_user.dart' as _i3;
import 'common/us/find_logged_user_impl.dart' as _i4;
import 'sign_in/sign_in_view_model.dart' as _i10;
import 'sign_in/uc/perform_sign_in.dart' as _i6;
import 'sign_in/uc/perform_sign_in_impl.dart' as _i7;
import 'sign_up/sign_up_view_model.dart' as _i12;
import 'sign_up/uc/perform_sign_up.dart' as _i8;
import 'sign_up/uc/perform_sign_up_impl.dart' as _i9;
import 'splash/splash_screen_view_model.dart' as _i13;
import 'splash/splash_screen_view_model_params.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initPresenterGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.FindLoggedUser>(
      () => _i4.FindLoggedUserImpl(userRepository: get<_i5.UserRepository>()));
  gh.factory<_i6.PerformSignIn>(() =>
      _i7.PerformSignInImpl(userRepository: get<_i5.UserCmdRepository>()));
  gh.factory<_i8.PerformSignUp>(() =>
      _i9.PerformSignUpImpl(userRepository: get<_i5.UserCmdRepository>()));
  gh.factory<_i10.SignInViewModel>(() => _i10.SignInViewModelImpl(
      futureRunner: get<_i11.FutureRunner>(),
      findLoggedUser: get<_i3.FindLoggedUser>(),
      performSignIn: get<_i6.PerformSignIn>()));
  gh.factory<_i12.SignUpViewModel>(() => _i12.SignUpViewModelImpl(
      futureRunner: get<_i11.FutureRunner>(),
      performSignUp: get<_i8.PerformSignUp>()));
  gh.factoryParam<_i13.SplashScreenViewModel, _i14.SplashScreenViewModelParams,
          dynamic>(
      (params, _) => _i13.SplashScreenViewModelImpl(
          params: params, futureRunner: get<_i11.FutureRunner>()));
  return get;
}
