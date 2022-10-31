import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:instak4u/feed/feed_screen.dart';
import 'package:presenter/common.dart';
import 'package:presenter/feed.dart';

class FeedPage extends Page {
  final FeedViewModel viewModel;
  final UserView? userView;
  final void Function(EventDetailsView)? onShowEventDetails;
  final void Function()? onLoggedOut;
  final void Function()? onNavigateBack;

  FeedPage({
    this.userView,
    this.onShowEventDetails,
    this.onLoggedOut,
    this.onNavigateBack,
  })  : viewModel = GetIt.I.get<FeedViewModel>(),
        super(key: const ValueKey(FeedPage));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return FeedScreen(
          viewModel: viewModel,
          userView: userView,
          onShowEventDetails: onShowEventDetails,
          onLoggedOut: onLoggedOut,
          onNavigateBack: onNavigateBack,
        );
      },
    );
  }
}
