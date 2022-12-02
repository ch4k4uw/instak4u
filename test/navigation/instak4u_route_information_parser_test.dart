import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instak4u/navigation/instak4u_route_information_parser.dart';
import 'package:instak4u/navigation/instak4u_route_path.dart';

import '../common/global_extensions.dart';
import '../common/stuff/event_details_view_fixture.dart';
import '../common/stuff/user_view_fixture.dart';

void main() {
  setUp(() {
    disableLog();
  });
  group("route information parser", () {
    test('valid routes and params', () async {
      const basePath = "htts://localhost";
      const encodedUser = UserViewFixture.encodedUser;
      const encodedEventDetails = EventDetailsViewFixture.encodedEventDetails;
      final parser = Instak4uRouteInformationParser();

      const signInInformation = RouteInformation(
        location: "$basePath/sign/in",
      );
      const signUpInformation = RouteInformation(
        location: "$basePath/sign/up",
      );
      const startingFeedInformation = RouteInformation(
        location: "$basePath/feed",
      );
      const feedInformation = RouteInformation(
        location: "$basePath/feed?loggedUser=$encodedUser",
      );
      const startingEventDetailsInformation =
          RouteInformation(location: "$basePath/event/details/1");
      const eventDetailsInformation = RouteInformation(
          location: "$basePath/event/details?loggedUser=$encodedUser&"
              "eventDetails=$encodedEventDetails");

      final signInPath = await parser.parseRouteInformation(signInInformation);
      final signUpPath = await parser.parseRouteInformation(signUpInformation);
      final startingFeedPath = await parser.parseRouteInformation(
        startingFeedInformation,
      );
      final startingEventDetailsPath = await parser.parseRouteInformation(
        startingEventDetailsInformation,
      );
      final feedPath = await parser.parseRouteInformation(feedInformation);
      final eventDetailsPath = await parser.parseRouteInformation(
        eventDetailsInformation,
      );

      expect(signInPath, isA<Instak4uRouteSignIn>());
      expect(signUpPath, isA<Instak4uRouteSignUp>());
      expect(startingFeedPath, isA<Instak4uRouteRedirect>());
      expect(startingFeedPath, isA<Instak4uRouteRedirectToFeed>());
      expect(startingEventDetailsPath, isA<Instak4uRouteRedirect>());
      expect(
        startingEventDetailsPath,
        isA<Instak4uRouteRedirectToEventDetails>(),
      );
      expect(feedPath, isA<Instak4uRouteFeed>());
      expect(eventDetailsPath, isA<Instak4uRouteEventDetails>());

      final eventDetailsRedirectRoute =
          startingEventDetailsPath as Instak4uRouteRedirectToEventDetails;
      expect(eventDetailsRedirectRoute.eventId, equals("1"));

      final feedRoute = feedPath as Instak4uRouteFeed;
      expect(feedRoute.loggedUser, UserViewFixture.user);

      final eventDetailsRoute = eventDetailsPath as Instak4uRouteEventDetails;
      expect(eventDetailsRoute.loggedUser, equals(UserViewFixture.user));
      expect(
        eventDetailsRoute.eventDetails,
        equals(EventDetailsViewFixture.eventDetails),
      );
    });

    test('invalid routes and params', () async {
      const encodedUser = UserViewFixture.encodedUser;
      const basePath = "htts://localhost";
      final parser = Instak4uRouteInformationParser();

      const invalidSignUpInformation = RouteInformation(
        location: "$basePath/sign/up/register",
      );
      const invalidStartingFeedInformation = RouteInformation(
        location: "$basePath/feed/details",
      );
      const invalidFeedQueryParamInformation = RouteInformation(
        location: "$basePath/feed?loggedUser=xxxx",
      );
      const invalidStartingEventDetailsInformation =
          RouteInformation(location: "$basePath/event/details/1/more");
      const invalidEventDetailsQueryParamInformation = RouteInformation(
          location: "$basePath/event/details?loggedUser=$encodedUser&"
              "eventDetails=yyyy");

      Future<Instak4uRoutePath> parse(RouteInformation information) async {
        return await parser.parseRouteInformation(
          information,
        );
      }

      final invalidSignUpPath = await parse(
        invalidSignUpInformation,
      );
      final invalidStartingFeedPath = await parse(
        invalidStartingFeedInformation,
      );
      final invalidStartingEventDetailsPath = await parse(
        invalidStartingEventDetailsInformation,
      );
      final invalidFeedQueryParamPath =
          await parse(invalidFeedQueryParamInformation);
      final invalidEventDetailsQueryParamPath = await parse(
        invalidEventDetailsQueryParamInformation,
      );

      expect(invalidSignUpPath, isA<Instak4uRouteRedirectToFeed>());
      expect(invalidStartingFeedPath, isA<Instak4uRouteRedirectToFeed>());
      expect(
        invalidStartingEventDetailsPath,
        isA<Instak4uRouteRedirectToFeed>(),
      );
      expect(invalidFeedQueryParamPath, isA<Instak4uRouteRedirectToFeed>());
      expect(invalidEventDetailsQueryParamPath,
          isA<Instak4uRouteRedirectToFeed>());
    });
  });
}
