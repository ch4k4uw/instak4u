import 'package:core/common.dart';
import 'package:core/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:instak4u/navigation/instak4u_route_path.dart';
import 'package:instak4u/navigation/page/feed_page.dart';
import 'package:instak4u/navigation/page/sign_in_page.dart';
import 'package:instak4u/navigation/page/sign_up_page.dart';
import 'package:instak4u/navigation/page/splash_screen_page.dart';
import 'package:presenter/common.dart';

import 'page/event_details_page.dart';

class Instak4uRouterDelegate extends RouterDelegate<Instak4uRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Instak4uRoutePath> {
  @override
  final GlobalKey<NavigatorState>? navigatorKey;

  Instak4uRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Instak4uRoutePath? get currentConfiguration {
    final isFeedRoute = _currentConfiguration.isFeedRoutePath;
    final isEventDetailsRoute = _currentConfiguration.isEventDetailsRoutePath;
    final isSignIn = _currentConfiguration.isSignInRoutePath;
    final isSignUp = _currentConfiguration.isSignUpRoutePath;
    if (isFeedRoute || isEventDetailsRoute || isSignIn || isSignUp) {
      return _currentConfiguration;
    }
    return null;
  }

  Instak4uRoutePath? _currentConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        ..._currentConfiguration.onSplash((detailId) => [
              SplashScreenPage(
                eventDetailId: detailId,
                onShowSignIn: () {
                  _replacePath(
                    context: context,
                    newPath: const Instak4uRouteSignIn(),
                  );
                },
                onShowFeed: (user) {
                  _replacePath(
                    context: context,
                    newPath: Instak4uRouteFeed(loggedUser: user),
                  );
                },
                onShowEventDetails: (user, event) {
                  _replacePath(
                    context: context,
                    newPath: Instak4uRouteEventDetails(
                      loggedUser: user,
                      eventDetails: event,
                    ),
                  );
                },
              )
            ]),
        ..._currentConfiguration.onSign((isSignUp) => [
              SignInPage(
                onSignedIn: (user) {
                  _replacePath(
                    context: context,
                    newPath: Instak4uRouteFeed(loggedUser: user),
                  );
                },
                onNavigateToSignUp: () {
                  _addPath(
                    context: context,
                    newPath: const Instak4uRouteSignUp(),
                  );
                },
              ),
              if (isSignUp)
                SignUpPage(
                  onSignedIn: (user) {
                    _replacePath(
                      context: context,
                      newPath: Instak4uRouteFeed(loggedUser: user),
                    );
                  },
                  onNavigateBack: (context) {
                    Navigator.pop(context);
                  },
                )
            ]),
        ..._currentConfiguration.onFeed((userView) => _feedStack(
              context: context,
              user: userView,
            )),
        ..._currentConfiguration.onEventDetail(
          (userView, details) => _eventDetailsStack(
            context: context,
            event: details,
            user: userView,
          ),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _currentConfiguration = _currentConfiguration?.let((it) {
          if (it is Instak4uRouteEventDetails) {
            return Instak4uRouteFeed(loggedUser: it.loggedUser);
          }
          return const Instak4uRouteSignIn();
        });

        notifyListeners();

        return true;
      },
    );
  }

  void _replacePath({
    required BuildContext context,
    required Instak4uRoutePath newPath,
  }) {
    Router.neglect(context, () {
      _currentConfiguration = newPath;
      notifyListeners();
    });
  }

  void _addPath({
    required BuildContext context,
    required Instak4uRoutePath newPath,
  }) {
    _currentConfiguration = newPath;
    notifyListeners();
  }

  List<Page<dynamic>> _feedStack({
    required BuildContext context,
    required UserView user,
  }) {
    return [
      FeedPage(
        userView: user,
        onShowEventDetails: (eventDetailsView) {
          _addPath(
            context: context,
            newPath: Instak4uRouteEventDetails(
              loggedUser: user,
              eventDetails: eventDetailsView,
            ),
          );
        },
        onLoggedOut: () {
          _replacePath(
            context: context,
            newPath: const Instak4uRouteSignIn(),
          );
        },
        onNavigateBack: () {
          if (!kIsWeb) {
            SystemNavigator.pop(animated: true);
          }
        },
      )
    ];
  }

  List<Page<dynamic>> _eventDetailsStack({
    required BuildContext context,
    required EventDetailsView event,
    required UserView user,
  }) {
    _registerBuilder(scope: "details", context: context);
    return [
      ..._feedStack(context: context, user: user),
      EventDetailsPage(
        eventDetailsView: event,
        userView: user,
        onLoggedOut: () {
          _replacePath(
            context: context,
            newPath: const Instak4uRouteSignIn(),
          );
        },
        onNavigateBack: () {
          _addPath(
            context: context,
            newPath: Instak4uRouteFeed(
              loggedUser: user,
            ),
          );
        },
      )
    ];
  }

  void _registerBuilder({
    required String scope,
    required BuildContext context,
  }) {
    if (GetIt.I.currentScopeName == scope) {
      return;
    }
    GetIt.I.pushNewScope(scopeName: scope);
    injectBuildContext(context: context);
  }

  @override
  Future<void> setNewRoutePath(Instak4uRoutePath configuration) async {
    if (_currentConfiguration == null) {
      configuration.onFeedRoutePath((path) {
        _currentConfiguration = const Instak4uRouteRedirectToFeed();
      }).onEventDetailsRoutePath((path) {
        _currentConfiguration = Instak4uRouteRedirectToEventDetails(
          eventId: path.eventDetails.id,
        );
      });
      final isNewRouteDisabled = configuration.isFeedRoutePath ||
          configuration.isEventDetailsRoutePath;
      if (isNewRouteDisabled) {
        return;
      }
    }
    if (_currentConfiguration.isSignInRoutePath) {
      if (configuration.isFeedRoutePath ||
          configuration.isEventDetailsRoutePath) {
        return;
      }
    }
    _currentConfiguration = configuration;
  }

  @override
  Future<bool> popRoute() async {
    final curr = _currentConfiguration;
    return (await super.popRoute()).also((it) {
      if (it && curr is Instak4uRouteEventDetails) {
        GetIt.I.popScope();
      }
    });
  }
}

extension _Instak4uRoutePathExtension on Instak4uRoutePath? {
  List<Page> onSplash(List<Page> Function(String? detailId) block) {
    final detailId = this
        ?.takeIf((it) => it is Instak4uRouteRedirectToEventDetails)
        ?.let((it) => it as Instak4uRouteRedirectToEventDetails?)
        ?.let((it) => it.eventId);

    if (this == null || (this is! Instak4uRouteRedirect)) {
      return [];
    }
    return block(detailId);
  }

  List<Page> onSign(List<Page> Function(bool isSignUp) block) {
    if (this == null) {
      return block(false);
    }

    final isSignIn = this is Instak4uRouteSignIn;
    final isSignUp = this is Instak4uRouteSignUp;

    return this
            ?.takeIf((_) => isSignIn || isSignUp)
            ?.let((_) => block(isSignUp)) ??
        [];
  }

  List<Page> onFeed(List<Page> Function(UserView userView) block) {
    return this
            ?.takeIf((it) => it is Instak4uRouteFeed)
            ?.let((it) => it as Instak4uRouteFeed)
            .let((it) => block(it.loggedUser)) ??
        [];
  }

  List<Page> onEventDetail(
      List<Page> Function(UserView userView, EventDetailsView details) block) {
    return this
            ?.takeIf((it) => it is Instak4uRouteEventDetails)
            ?.let((it) => it as Instak4uRouteEventDetails)
            .let((it) => block(it.loggedUser, it.eventDetails)) ??
        [];
  }
}
