import 'package:flutter/material.dart';
import 'package:instak4u/navigation/instak4u_route_path.dart';
import 'package:instak4u/navigation/page/sign_in_page.dart';
import 'package:instak4u/navigation/page/sign_up_page.dart';
import 'package:instak4u/navigation/page/splash_screen_page.dart';
import 'package:presenter/common.dart';

class Instak4uRouterDelegate extends RouterDelegate<Instak4uRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Instak4uRoutePath> {
  @override
  final GlobalKey<NavigatorState>? navigatorKey;

  bool _isSignInRequired = false;

  bool _isSignUpRequired = false;

  UserView _loggedUser = UserView.empty;

  bool get _isLoggedIn => _loggedUser != UserView.empty;

  String? _rawEventDetails;

  bool get _isShowEventDetailsRedirection => _rawEventDetails != null;

  EventDetailsView _eventDetailsView = EventDetailsView.empty;

  bool get _isShowEventDetail => _eventDetailsView != EventDetailsView.empty;

  bool get _isShowFeedRedirection =>
      !_isLoggedIn && !_isShowEventDetailsRedirection && !_isSignInRequired;

  Instak4uRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  String toString() {
    return 'Instak4uRouterDelegate{_isSignInRequired: $_isSignInRequired, _isSignUpRequired: $_isSignUpRequired, _loggedUser: $_loggedUser, _rawEventDetails: $_rawEventDetails, _eventDetailsView: $_eventDetailsView}';
  }

  @override
  Instak4uRoutePath get currentConfiguration {
    if (!_isLoggedIn && _isShowEventDetailsRedirection) {
      return Instak4uRouteRedirectToEventDetails(
        eventId: _rawEventDetails ?? "",
      );
    }
    if (!_isLoggedIn && !_isShowEventDetailsRedirection) {
      if (!_isSignInRequired) {
        return const Instak4uRouteRedirectToFeed();
      }
    }
    if (_isLoggedIn) {
      if (!_isShowEventDetail) {
        return Instak4uRouteFeed(loggedUser: _loggedUser);
      }
      return Instak4uRouteEventDetails(
        loggedUser: _loggedUser,
        eventDetails: _eventDetailsView,
      );
    }
    if (_isSignUpRequired) {
      return const Instak4uRouteSignUp();
    }
    return const Instak4uRouteSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_isShowFeedRedirection || _isShowEventDetailsRedirection)
          SplashScreenPage(
            eventDetailId: _rawEventDetails,
            onShowSignIn: () {
              popRoute();
              _switchToSignInState();
              notifyListeners();
            },
            onShowFeed: (user) {
              _switchToFeedState(user: user);
              notifyListeners();
            },
            onShowEventDetails: (user, event) {
              _switchToEventDetailsState(user: user, event: event);
              notifyListeners();
            },
          )
        else if (_isSignInRequired) ...[
          SignInPage(
            onSignedIn: (user) {
              _switchToFeedState(user: user);
              notifyListeners();
            },
            onNavigateToSignUp: () {
              _isSignUpRequired = true;
              notifyListeners();
            },
          ),
          if (_isSignUpRequired)
            SignUpPage(
              onSignedIn: (user) {
                _switchToFeedState(user: user);
                notifyListeners();
              },
              onNavigateBack: (context) {
                _isSignUpRequired = false;
                notifyListeners();
              },
            )
        ]
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (_isSignUpRequired) {
          _isSignUpRequired = false;
        } else if (_isSignInRequired) {
          _isSignInRequired = false;
        } else if (_isShowEventDetail) {
          _eventDetailsView = EventDetailsView.empty;
        }

        notifyListeners();

        return true;
      },
    );
  }

  void _switchToSignInState() {
    _rawEventDetails = null;
    _loggedUser = UserView.empty;
    _eventDetailsView = EventDetailsView.empty;
    _isSignInRequired = true;
  }

  void _switchToFeedState({required UserView user}) {
    _rawEventDetails = null;
    _loggedUser = user;
    _eventDetailsView = EventDetailsView.empty;
    _isSignInRequired = false;
  }

  void _switchToEventDetailsState({
    required UserView user,
    required EventDetailsView event,
  }) {
    _rawEventDetails = null;
    _loggedUser = user;
    _eventDetailsView = event;
    _isSignInRequired = false;
  }

  @override
  Future<void> setNewRoutePath(Instak4uRoutePath configuration) async {
    if (configuration is Instak4uRouteRedirect) {
      final isRedirectToEventDetails =
          configuration is Instak4uRouteRedirectToEventDetails;

      _rawEventDetails =
          isRedirectToEventDetails ? configuration.eventId : null;
      _loggedUser = UserView.empty;
      _eventDetailsView = EventDetailsView.empty;
      _isSignInRequired = false;
      return;
    }

    if (configuration is Instak4uRouteFeed) {
      _switchToFeedState(user: configuration.loggedUser);
      return;
    }

    if (configuration is Instak4uRouteEventDetails) {
      _rawEventDetails = null;
      _loggedUser = configuration.loggedUser;
      _eventDetailsView = configuration.eventDetails;
      _isSignInRequired = false;
      return;
    }

    _switchToSignInState();

    _isSignUpRequired = configuration is Instak4uRouteSignUp;
  }
}
