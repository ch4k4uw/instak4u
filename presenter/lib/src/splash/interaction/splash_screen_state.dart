import 'package:presenter/common.dart';

abstract class SplashScreenState {
  static final SplashScreenState showSignInScreen = _ConstState();

  const SplashScreenState();
}

class _ConstState extends SplashScreenState {}

class SplashScreenStateNotInitialized extends SplashScreenState {
  final Object cause;

  const SplashScreenStateNotInitialized({required this.cause});
}

class SplashScreenStateShowFeedScreen extends SplashScreenState {
  final UserView user;

  const SplashScreenStateShowFeedScreen({required this.user});
}

class SplashScreenStateEventDetailsSuccessfulLoaded extends SplashScreenState {
  final UserView user;
  final EventDetailsView eventDetails;

  const SplashScreenStateEventDetailsSuccessfulLoaded({
    required this.user,
    required this.eventDetails,
  });
}

class SplashScreenStateEventDetailsNotLoaded extends SplashScreenState {
  final Object cause;

  const SplashScreenStateEventDetailsNotLoaded({required this.cause});
}
