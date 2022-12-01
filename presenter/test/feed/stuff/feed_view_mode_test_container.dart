import 'package:presenter/common.dart';
import 'package:presenter/src/feed/uc/find_all_events.dart';
import 'package:presenter/src/feed/uc/find_event_details.dart';

import '../../ui_state_observer.dart';
import '../../unawaited_future_runner.dart';
import '../feed_view_model_test.mocks.dart';

class FeedViewModelTestContainer {
  final MockFindAllEvents findAllEvents;
  final MockFindEventDetails findEventDetails;
  final MockPerformLogout performLogout;
  final MockUiStateObserver uiStateObserver;
  final UnawaitedFutureRunner futureRunner;

  const FeedViewModelTestContainer({
    required this.findAllEvents,
    required this.findEventDetails,
    required this.performLogout,
    required this.uiStateObserver,
    required this.futureRunner,
  });
}
