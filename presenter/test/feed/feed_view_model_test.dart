import 'package:core/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:presenter/common.dart';
import 'package:presenter/src/feed/interaction/feed_state.dart';
import 'package:presenter/src/feed/uc/find_all_events.dart';
import 'package:presenter/src/feed/uc/find_event_details.dart';

import '../common/extensions/global_extensions.dart';
import '../ui_state_observer.dart';
import '../unawaited_future_runner.dart';
@GenerateNiceMocks([
  MockSpec<FindAllEvents>(),
  MockSpec<FindEventDetails>(),
  MockSpec<PerformLogout>(),
  MockSpec<UiStateObserver<FeedState>>(),
])
import 'feed_view_model_test.mocks.dart';
import 'stuff/feed_view_mode_test_container.dart';
import 'stuff/feed_view_model_event_fetching_test_cases.dart';
import 'stuff/feed_view_model_logout_test_cases.dart';

void main() {
  final futureRunner = UnawaitedFutureRunner();
  final findAllEvents = MockFindAllEvents();
  final findEventDetails = MockFindEventDetails();
  final performLogout = MockPerformLogout();
  final uiStateObserver = MockUiStateObserver();

  final testContainer = Lazy<FeedViewModelTestContainer>(
    creator: () => FeedViewModelTestContainer(
      findAllEvents: findAllEvents,
      findEventDetails: findEventDetails,
      performLogout: performLogout,
      uiStateObserver: uiStateObserver,
      futureRunner: futureRunner,
    ),
  );

  final feedFetchingTestCases = Lazy<FeedViewModelEventFetchingTestCases>(
    creator: () => FeedViewModelEventFetchingTestCases(
      container: testContainer.value,
    ),
  );

  final feedViewModelLogoutTestCases = Lazy<FeedViewModelLogoutTestCases>(
    creator: () => FeedViewModelLogoutTestCases(
      container: testContainer.value,
    ),
  );

  setUp(() {
    disableLog();
  });

  group('feed', () {
    group('fetching', () {
      test('it should fetch all feed events', () async {
        feedFetchingTestCases.value.case1();
      });
      test('it shouldn\'t fetch the feed events', () async {
        feedFetchingTestCases.value.case2();
      });
      test('it should fetch an event details', () async {
        feedFetchingTestCases.value.case3();
      });
      test('it shouldn\'t fetch the event', () async {
        feedFetchingTestCases.value.case4();
      });
    });

    group('logout', () {
      test('it should successfully perform logout', () async {
        feedViewModelLogoutTestCases.value.case1();
      });
    });
  });
}
