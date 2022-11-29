import 'package:core/common.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/common.dart';
import 'package:presenter/src/common/interaction/user_view.dart';
import '../../feed.dart';
import '../common/uc/find_logged_user.dart';
import 'package:presenter/src/splash/splash_screen_view_model_params.dart';

import 'interaction/splash_screen_state.dart';

abstract class SplashScreenViewModel extends AppViewModel<SplashScreenState> {
  factory SplashScreenViewModel({
    FutureRunner? futureRunner,
    required SplashScreenViewModelParams params,
    required FindLoggedUser findLoggedUser,
    required FindEventDetails findEventDetails,
  }) = SplashScreenViewModelImpl;
}

@Injectable(as: SplashScreenViewModel)
class SplashScreenViewModelImpl extends AppBaseViewModel<SplashScreenState>
    implements SplashScreenViewModel {
  final SplashScreenViewModelParams params;
  final FindLoggedUser _findLoggedUser;
  final FindEventDetails _findEventDetails;

  SplashScreenViewModelImpl({
    FutureRunner? futureRunner,
    @factoryParam required this.params,
    required FindLoggedUser findLoggedUser,
    required FindEventDetails findEventDetails,
  })  : _findLoggedUser = findLoggedUser,
        _findEventDetails = findEventDetails,
        super(futureRunner: futureRunner) {
    runFuture(() async {
      send(await _init());
    });
  }

  Future<SplashScreenState> _init() async {
    try {
      final user = (await _findLoggedUser()).asView;
      if (user != UserView.empty) {
        final eventDetailId = params.eventDetailId;
        if (eventDetailId != null) {
          final eventDetails = await _findDetails(
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

  Future<EventDetailsView> _findDetails({
    required String eventDetailId,
  }) async {
    final event = await _findEventDetails(id: eventDetailId);
    return event.asEventDetailsView;
  }
}
