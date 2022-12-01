// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core/common.dart' as _i24;
import 'package:domain/check_in.dart' as _i13;
import 'package:domain/credential.dart' as _i10;
import 'package:domain/feed.dart' as _i5;
import 'package:flutter/material.dart' as _i22;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:presenter/feed.dart' as _i28;
import 'package:presenter/src/common/interaction/event_details_view.dart'
    as _i30;
import 'package:presenter/src/common/uc/find_logged_user.dart' as _i8;
import 'package:presenter/src/common/uc/find_logged_user_impl.dart' as _i9;
import 'package:presenter/src/common/uc/perform_logout.dart' as _i14;
import 'package:presenter/src/common/uc/perform_logout_impl.dart' as _i15;
import 'package:presenter/src/common/uc/share_event.dart' as _i20;
import 'package:presenter/src/common/uc/share_event_impl.dart' as _i21;
import 'package:presenter/src/event/event_details_view_model.dart' as _i29;
import 'package:presenter/src/event/uc/perform_check_in.dart' as _i11;
import 'package:presenter/src/event/uc/perform_check_in_impl.dart' as _i12;
import 'package:presenter/src/feed/feed_view_model.dart' as _i31;
import 'package:presenter/src/feed/uc/find_all_events.dart' as _i3;
import 'package:presenter/src/feed/uc/find_all_events_impl.dart' as _i4;
import 'package:presenter/src/feed/uc/find_event_details.dart' as _i6;
import 'package:presenter/src/feed/uc/find_event_details_impl.dart' as _i7;
import 'package:presenter/src/sign_in/sign_in_view_model.dart' as _i23;
import 'package:presenter/src/sign_in/uc/perform_sign_in.dart' as _i16;
import 'package:presenter/src/sign_in/uc/perform_sign_in_impl.dart' as _i17;
import 'package:presenter/src/sign_up/sign_up_view_model.dart' as _i25;
import 'package:presenter/src/sign_up/uc/perform_sign_up.dart' as _i18;
import 'package:presenter/src/sign_up/uc/perform_sign_up_impl.dart' as _i19;
import 'package:presenter/src/splash/splash_screen_view_model.dart' as _i26;
import 'package:presenter/src/splash/splash_screen_view_model_params.dart'
    as _i27;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt $initPresenterGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.FindAllEvents>(
        () => _i4.FindAllEventsImpl(repository: gh<_i5.EventRepository>()));
    gh.factory<_i6.FindEventDetails>(
        () => _i7.FindEventDetailsImpl(repository: gh<_i5.EventRepository>()));
    gh.factory<_i8.FindLoggedUser>(() =>
        _i9.FindLoggedUserImpl(userRepository: gh<_i10.UserRepository>()));
    gh.factory<_i11.PerformCheckIn>(() => _i12.PerformCheckInImpl(
        checkInRepository: gh<_i13.CheckInCmdRepository>()));
    gh.factory<_i14.PerformLogout>(
        () => _i15.PerformLogoutImpl(repository: gh<_i10.UserCmdRepository>()));
    gh.factory<_i16.PerformSignIn>(() =>
        _i17.PerformSignInImpl(userRepository: gh<_i10.UserCmdRepository>()));
    gh.factory<_i18.PerformSignUp>(() =>
        _i19.PerformSignUpImpl(userRepository: gh<_i10.UserCmdRepository>()));
    gh.factory<_i20.ShareEvent>(() => _i21.ShareEventImpl(
          context: gh<_i22.BuildContext>(),
          eventRepository: gh<_i5.EventRepository>(),
        ));
    gh.factory<_i23.SignInViewModel>(() => _i23.SignInViewModelImpl(
          futureRunner: gh<_i24.FutureRunner>(),
          findLoggedUser: gh<_i8.FindLoggedUser>(),
          performSignIn: gh<_i16.PerformSignIn>(),
        ));
    gh.factory<_i25.SignUpViewModel>(() => _i25.SignUpViewModelImpl(
          futureRunner: gh<_i24.FutureRunner>(),
          performSignUp: gh<_i18.PerformSignUp>(),
        ));
    gh.factoryParam<_i26.SplashScreenViewModel,
        _i27.SplashScreenViewModelParams, dynamic>((
      params,
      _,
    ) =>
        _i26.SplashScreenViewModelImpl(
          futureRunner: gh<_i24.FutureRunner>(),
          params: params,
          findLoggedUser: gh<_i8.FindLoggedUser>(),
          findEventDetails: gh<_i28.FindEventDetails>(),
        ));
    gh.factoryParam<_i29.EventDetailsViewModel, _i30.EventDetailsView, dynamic>(
        (
      eventDetails,
      _,
    ) =>
            _i29.EventDetailsViewModelImpl(
              futureRunner: gh<_i24.FutureRunner>(),
              eventDetails: eventDetails,
              performCheckIn: gh<_i11.PerformCheckIn>(),
              shareEvent: gh<_i20.ShareEvent>(),
              performLogout: gh<_i14.PerformLogout>(),
            ));
    gh.factory<_i31.FeedViewModel>(() => _i31.FeedViewModelImpl(
          futureRunner: gh<_i24.FutureRunner>(),
          findAllEvents: gh<_i3.FindAllEvents>(),
          findEventDetails: gh<_i6.FindEventDetails>(),
          performLogout: gh<_i14.PerformLogout>(),
        ));
    return this;
  }
}
