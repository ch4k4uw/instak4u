import 'package:core/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/navigation/instak4u_route_path.dart';
import 'package:presenter/common.dart';

const _signInNavigationPathSegments = ["sign", "in"];

const _signUpNavigationPathSegments = ["sign", "up"];

const _feedNavigationPathSegments = ["feed"];
const _feedNavigationUserArgName = "loggedUser";

const _eventDetailsNavigationPathSegments = ["event", "details"];
const _eventDetailsNavigationUserArgName = "loggedUser";
const _eventDetailsNavigationEventArgName = "eventDetails";

class Instak4uRouteInformationParser
    extends RouteInformationParser<Instak4uRoutePath> {
  @override
  Future<Instak4uRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    final uri = Uri.parse(routeInformation.location ?? "");
    var result = _assertEventDetailsPath(uri: uri);
    result ??= _assertFeedPath(uri: uri);
    result ??= _assertSignUpPath(uri: uri);
    result ??= _assertSignInPath(uri: uri);
    result ??= _fallbackPath();
    return result.asSynchronousFuture;
  }

  Instak4uRoutePath? _assertEventDetailsPath({required Uri uri}) {
    const pathSegments = _eventDetailsNavigationPathSegments;

    var isThePath = uri.pathSegments.isNotEmpty;
    isThePath = isThePath && uri.pathSegments.length >= 2;
    isThePath = isThePath && uri.pathSegments[0] == pathSegments[0];
    isThePath = isThePath && uri.pathSegments[1] == pathSegments[1];

    if (!isThePath) {
      return null;
    }

    var isStartingRoute = uri.pathSegments.length == 3;
    isStartingRoute = isStartingRoute && uri.queryParameters.isEmpty;

    if (isStartingRoute) {
      return Instak4uRouteRedirectToEventDetails(
        eventId: uri.pathSegments[2],
      );
    }

    final isValidRoute = uri.queryParameters.length == 2;

    if (!isValidRoute) {
      return null;
    }

    const userArgName = _eventDetailsNavigationUserArgName;
    const eventArgName = _eventDetailsNavigationEventArgName;

    final user = _decodeUser(data: uri.queryParameters[userArgName]!);
    final event = _decodeEventDetails(
      data: uri.queryParameters[eventArgName]!,
    );

    final isEmptyUser = user == UserView.empty;
    final isEmptyDetails = event == EventDetailsView.empty;
    final isEmpty = isEmptyUser || isEmptyDetails;

    return isEmpty
        ? null
        : Instak4uRouteEventDetails(
            loggedUser: user,
            eventDetails: event,
          );
  }

  UserView _decodeUser({required String data}) {
    try {
      return data.unmarshallToUserView();
    } catch (e) {
      _print(e);
      return UserView.empty;
    }
  }

  void _print(Object obj) {
    if (kDebugMode) {
      debugPrint(obj.toString());
    }
  }

  EventDetailsView _decodeEventDetails({required String data}) {
    try {
      return data.unmarshallToEventDetailsView();
    } catch (e) {
      _print(e);
      return EventDetailsView.empty;
    }
  }

  Instak4uRoutePath? _assertFeedPath({required Uri uri}) {
    const pathSegments = _feedNavigationPathSegments;

    var isThePath = uri.pathSegments.length == 1;
    isThePath = isThePath && uri.pathSegments[0] == pathSegments[0];

    if (!isThePath) {
      return null;
    }

    var isStartingRoute = uri.queryParameters.isEmpty;
    if (isStartingRoute) {
      return const Instak4uRouteRedirectToFeed();
    }

    const userArgName = _feedNavigationUserArgName;

    final user = _decodeUser(data: uri.queryParameters[userArgName]!);
    final isEmptyUser = user == UserView.empty;

    return isEmptyUser ? null : Instak4uRouteFeed(loggedUser: user);
  }

  Instak4uRoutePath? _assertSignUpPath({required Uri uri}) {
    const pathSegments = _signUpNavigationPathSegments;

    var isThePath = uri.pathSegments.length == 2;
    isThePath = isThePath && uri.pathSegments[0] == pathSegments[0];
    isThePath = isThePath && uri.pathSegments[1] == pathSegments[1];

    if (!isThePath) {
      return null;
    }
    return const Instak4uRouteSignUp();
  }

  Instak4uRoutePath? _assertSignInPath({required Uri uri}) {
    const pathSegments = _signInNavigationPathSegments;

    var isThePath = uri.pathSegments.length == 2;
    isThePath = isThePath && uri.pathSegments[0] == pathSegments[0];
    isThePath = isThePath && uri.pathSegments[1] == pathSegments[1];

    if (!isThePath) {
      return null;
    }
    return const Instak4uRouteSignIn();
  }

  Instak4uRoutePath _fallbackPath() => const Instak4uRouteRedirectToFeed();

  @override
  RouteInformation restoreRouteInformation(Instak4uRoutePath configuration) {
    if (configuration is Instak4uRouteRedirect) {
      if (configuration is Instak4uRouteRedirectToFeed) {
        final firstPathSegment = _feedNavigationPathSegments[0];
        final startingRoute = "/$firstPathSegment";
        return RouteInformation(location: startingRoute);
      }
      if (configuration is Instak4uRouteRedirectToEventDetails) {
        final firstPathSegment = _eventDetailsNavigationPathSegments[0];
        final secondPathSegment = _eventDetailsNavigationPathSegments[1];
        final startingRoute = "/$firstPathSegment/$secondPathSegment";
        final eventId = configuration.eventId;
        return RouteInformation(location: "$startingRoute/$eventId");
      }
    }
    if (configuration is Instak4uRouteFeed) {
      final firstPathSegment = _feedNavigationPathSegments[0];
      const userArgName = _feedNavigationUserArgName;
      final user = configuration.loggedUser.marshall();
      final route = "/$firstPathSegment?$userArgName=$user";
      return RouteInformation(location: route);
    }
    if (configuration is Instak4uRouteEventDetails) {
      final firstPathSegment = _eventDetailsNavigationPathSegments[0];
      final secondPathSegment = _eventDetailsNavigationPathSegments[1];
      final basePath = "/$firstPathSegment/$secondPathSegment";
      final user = configuration.loggedUser.marshall();
      final event = configuration.eventDetails.marshall();
      const userArgName = _eventDetailsNavigationUserArgName;
      const eventArgName = _eventDetailsNavigationEventArgName;
      final queryParams = "$userArgName=$user&$eventArgName=$event";
      return RouteInformation(location: "$basePath?$queryParams");
    }
    if (configuration is Instak4uRouteSignUp) {
      final firstPathSegment = _signUpNavigationPathSegments[0];
      final secondPathSegment = _signUpNavigationPathSegments[1];
      final route = "/$firstPathSegment/$secondPathSegment";
      return RouteInformation(location: route);
    }
    if (configuration is Instak4uRouteSignIn) {
      final firstPathSegment = _signInNavigationPathSegments[0];
      final secondPathSegment = _signInNavigationPathSegments[1];
      final route = "/$firstPathSegment/$secondPathSegment";
      return RouteInformation(location: route);
    }
    return const RouteInformation();
  }
}
