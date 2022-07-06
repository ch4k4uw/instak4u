import 'package:instak4u/navigation/instak4u_route_redirect_to.dart';
import 'package:presenter/common.dart';

abstract class Instak4uRoutePath {
  const Instak4uRoutePath();
}

class Instak4uRouteSignIn extends Instak4uRoutePath {}

class Instak4uRouteSignUp extends Instak4uRoutePath {}

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
