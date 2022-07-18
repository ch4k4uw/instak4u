import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:instak4u/splash/splash_screen_screen.dart';
import 'package:presenter/common.dart';
import 'package:presenter/splash.dart';

class SplashScreenPage extends Page {
  final SplashScreenViewModel viewModel;
  final void Function()? onShowSignIn;
  final void Function(UserView)? onShowFeed;
  final void Function(UserView, EventDetailsView)? onShowEventDetails;

  SplashScreenPage({
    String? eventDetailId,
    this.onShowSignIn,
    this.onShowFeed,
    this.onShowEventDetails,
  })  : viewModel = GetIt.I.get<SplashScreenViewModel>(
          param1: SplashScreenViewModelParams(eventDetailId: eventDetailId),
        ),
        super(key: ValueKey(eventDetailId ?? SplashScreenPage));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return SplashScreenScreen(
          viewModel: viewModel,
          onShowSignIn: onShowSignIn,
          onShowFeed: onShowFeed,
          onShowEventDetails: onShowEventDetails,
        );
      },
    );
  }
}
