import 'package:core/common/view_model/app_view_model.dart';
import 'package:core/common/view_model/future_runner.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/common.dart';
import 'package:presenter/src/splash/splash_screen_view_model_params.dart';

import 'interaction/splash_screen_state.dart';

abstract class SplashScreenViewModel extends AppViewModel<SplashScreenState> {
  factory SplashScreenViewModel({
    required SplashScreenViewModelParams params,
    FutureRunner? futureRunner,
  }) = SplashScreenViewModelImpl;
}

@Injectable(as: SplashScreenViewModel)
class SplashScreenViewModelImpl extends AppBaseViewModel<SplashScreenState>
    implements SplashScreenViewModel {
  final SplashScreenViewModelParams params;

  SplashScreenViewModelImpl({
    @factoryParam required this.params,
    FutureRunner? futureRunner,
  }) : super(futureRunner: futureRunner) {
    runFuture(() async {
      send(await _init());
    });
  }

  Future<SplashScreenState> _init() async {
    try {
      final user = await _findLoggedUser();
      if (user != UserView.empty) {
        final eventDetailId = params.eventDetailId;
        if (eventDetailId != null) {
          final eventDetails = await _findDetails(
            user: user,
            eventDetailId: eventDetailId,
          );
          if (eventDetails == EventDetailsView.empty) {
            return SplashScreenStateEventDetailsNotLoaded(
              cause: Exception("not fount"),
            );
          } else {
            return SplashScreenStateEventDetailsSuccessfulLoaded(
              user: user,
              eventDetails: eventDetails,
            );
          }
        } else {
          return SplashScreenStateShowFeedScreen(user: user);
        }
      } else {
        return SplashScreenState.showSignInScreen;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return SplashScreenStateNotInitialized(cause: e);
    }
  }

  Future<UserView> _findLoggedUser() async {
    return UserView.empty;
  }

  Future<EventDetailsView> _findDetails({
    required UserView user,
    required String eventDetailId,
  }) async {
    return EventDetailsView.empty;
  }
}
