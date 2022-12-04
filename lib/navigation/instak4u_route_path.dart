import 'package:instak4u/navigation/instak4u_route_redirect_to.dart';
import 'package:presenter/common.dart';

abstract class Instak4uRoutePath {
  const Instak4uRoutePath();
}

class Instak4uRouteSignIn extends Instak4uRoutePath {
  const Instak4uRouteSignIn();
}

class Instak4uRouteSignUp extends Instak4uRoutePath {
  const Instak4uRouteSignUp();
}

class Instak4uRouteFeed extends Instak4uRoutePath {
  final UserView loggedUser;

  const Instak4uRouteFeed({required this.loggedUser});
}

class Instak4uRouteEventDetails extends Instak4uRoutePath {
  final UserView loggedUser;
  final EventDetailsView eventDetails;

  const Instak4uRouteEventDetails({
    required this.loggedUser,
    required this.eventDetails,
  });
}

abstract class Instak4uRouteRedirect extends Instak4uRoutePath {
  final Instak4uRouteRedirectTo to;

  const Instak4uRouteRedirect({required this.to});
}

class Instak4uRouteRedirectToFeed extends Instak4uRouteRedirect {
  const Instak4uRouteRedirectToFeed()
      : super(to: Instak4uRouteRedirectTo.eventDetails);
}

class Instak4uRouteRedirectToEventDetails extends Instak4uRouteRedirect {
  final String eventId;

  const Instak4uRouteRedirectToEventDetails({required this.eventId})
      : super(to: Instak4uRouteRedirectTo.eventDetails);
}

extension Instak4uRoutePathExtension on Instak4uRoutePath {
  bool get isSplashRoutePath => this is Instak4uRouteRedirect;

  bool get isFeedRoutePath => this is Instak4uRouteFeed;

  bool get isEventDetailsRoutePath => this is Instak4uRouteEventDetails;

  bool get isSignInRoutePath => this is Instak4uRouteSignIn;

  bool get isSignUpRoutePath => this is Instak4uRouteSignUp;

  Instak4uRoutePath onFeedRoutePath(
    void Function(Instak4uRouteFeed path) block,
  ) {
    final route = this;
    if (route is Instak4uRouteFeed) {
      block(route);
    }
    return this;
  }

  Instak4uRoutePath onEventDetailsRoutePath(
    void Function(Instak4uRouteEventDetails path) block,
  ) {
    final route = this;
    if (route is Instak4uRouteEventDetails) {
      block(route);
    }
    return this;
  }
}

extension Instak4uRoutePathNullableExtension on Instak4uRoutePath? {
  bool get isSplashRoutePath => this?.isSplashRoutePath == true;

  bool get isFeedRoutePath => this?.isFeedRoutePath == true;

  bool get isEventDetailsRoutePath => this?.isEventDetailsRoutePath == true;

  bool get isSignInRoutePath => this?.isSignInRoutePath == true;

  bool get isSignUpRoutePath => this?.isSignUpRoutePath == true;
}
