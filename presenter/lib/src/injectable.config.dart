// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:core/common.dart' as _i22;
import 'package:domain/check_in.dart' as _i13;
import 'package:domain/credential.dart' as _i10;
import 'package:domain/feed.dart' as _i5;
import 'package:flutter/material.dart' as _i23;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'common/interaction/event_details_view.dart' as _i29;
import 'common/uc/find_logged_user.dart' as _i8;
import 'common/uc/find_logged_user_impl.dart' as _i9;
import 'common/uc/perform_logout.dart' as _i14;
import 'common/uc/perform_logout_impl.dart' as _i15;
import 'common/uc/share_event.dart' as _i20;
import 'common/uc/share_event_impl.dart' as _i21;
import 'event/event_details_view_model.dart' as _i28;
import 'event/uc/perform_check_in.dart' as _i11;
import 'event/uc/perform_check_in_impl.dart' as _i12;
import 'feed/feed_view_model.dart' as _i30;
import 'feed/uc/find_all_events.dart' as _i3;
import 'feed/uc/find_all_events_impl.dart' as _i4;
import 'feed/uc/find_event_details.dart' as _i6;
import 'feed/uc/find_event_details_impl.dart' as _i7;
import 'sign_in/sign_in_view_model.dart' as _i24;
import 'sign_in/uc/perform_sign_in.dart' as _i16;
import 'sign_in/uc/perform_sign_in_impl.dart' as _i17;
import 'sign_up/sign_up_view_model.dart' as _i25;
import 'sign_up/uc/perform_sign_up.dart' as _i18;
import 'sign_up/uc/perform_sign_up_impl.dart' as _i19;
import 'splash/splash_screen_view_model.dart' as _i26;
import 'splash/splash_screen_view_model_params.dart'
    as _i27; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initPresenterGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.FindAllEvents>(
      () => _i4.FindAllEventsImpl(repository: get<_i5.EventRepository>()));
  gh.factory<_i6.FindEventDetails>(
      () => _i7.FindEventDetailsImpl(repository: get<_i5.EventRepository>()));
  gh.factory<_i8.FindLoggedUser>(
      () => _i9.FindLoggedUserImpl(userRepository: get<_i10.UserRepository>()));
  gh.factory<_i11.PerformCheckIn>(() => _i12.PerformCheckInImpl(
      checkInRepository: get<_i13.CheckInCmdRepository>()));
  gh.factory<_i14.PerformLogout>(
      () => _i15.PerformLogoutImpl(repository: get<_i10.UserCmdRepository>()));
  gh.factory<_i16.PerformSignIn>(() =>
      _i17.PerformSignInImpl(userRepository: get<_i10.UserCmdRepository>()));
  gh.factory<_i18.PerformSignUp>(() =>
      _i19.PerformSignUpImpl(userRepository: get<_i10.UserCmdRepository>()));
  gh.factory<_i20.ShareEvent>(() => _i21.ShareEventImpl(
      context: get<_i22.Provider<_i23.BuildContext>>(),
      eventRepository: get<_i5.EventRepository>()));
  gh.factory<_i24.SignInViewModel>(() => _i24.SignInViewModelImpl(
      futureRunner: get<_i22.FutureRunner>(),
      findLoggedUser: get<_i8.FindLoggedUser>(),
      performSignIn: get<_i16.PerformSignIn>()));
  gh.factory<_i25.SignUpViewModel>(() => _i25.SignUpViewModelImpl(
      futureRunner: get<_i22.FutureRunner>(),
      performSignUp: get<_i18.PerformSignUp>()));
  gh.factoryParam<_i26.SplashScreenViewModel, _i27.SplashScreenViewModelParams,
          dynamic>(
      (params, _) => _i26.SplashScreenViewModelImpl(
          futureRunner: get<_i22.FutureRunner>(),
          params: params,
          findLoggedUser: get<_i8.FindLoggedUser>()));
  gh.factory<_i28.EventDetailsViewModel>(() => _i28.EventDetailsViewModelImpl(
      futureRunner: get<_i22.FutureRunner>(),
      eventDetails: get<_i29.EventDetailsView>(),
      performCheckIn: get<_i11.PerformCheckIn>(),
      shareEvent: get<_i20.ShareEvent>(),
      performLogout: get<_i14.PerformLogout>()));
  gh.factory<_i30.FeedViewModel>(() => _i30.FeedViewModelImpl(
      futureRunner: get<_i22.FutureRunner>(),
      findAllEvents: get<_i3.FindAllEvents>(),
      findEventDetails: get<_i6.FindEventDetails>(),
      performLogout: get<_i14.PerformLogout>()));
  return get;
}
