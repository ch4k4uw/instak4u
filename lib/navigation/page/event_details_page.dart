import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presenter/common.dart';
import 'package:presenter/event.dart';

import '../../event/event_details_screen.dart';

class EventDetailsPage extends Page {
  final EventDetailsViewModel? viewModel;
  final EventDetailsView? eventDetailsView;
  final UserView? userView;
  final void Function()? onLoggedOut;
  final void Function()? onNavigateBack;

  EventDetailsPage({
    this.eventDetailsView,
    this.userView,
    this.onLoggedOut,
    this.onNavigateBack,
  })  : viewModel = GetIt.I.get<EventDetailsViewModel>(
          param1: eventDetailsView.orEmpty(),
        ),
        super(key: const ValueKey(EventDetailsPage));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return EventDetailsScreen(
          viewModel: viewModel,
          userView: userView,
          onLoggedOut: onLoggedOut,
          onNavigateBack: onNavigateBack,
        );
      },
    );
  }
}
