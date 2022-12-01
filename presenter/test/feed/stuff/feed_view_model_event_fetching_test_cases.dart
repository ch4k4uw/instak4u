import 'package:mockito/mockito.dart';
import 'package:presenter/src/feed/interaction/feed_state.dart';

import '../../common/extensions/find_event_details_extensions.dart';
import '../../common/extensions/zone_extensions.dart';
import 'events_fixture.dart';
import 'feed_view_mode_test_container.dart';
import 'feed_view_model_test_cases.dart';

class FeedViewModelEventFetchingTestCases extends FeedViewModelTestCases {
  FeedViewModelEventFetchingTestCases({
    required FeedViewModelTestContainer container,
  }) : super(container: container);

  void case1() {
    container.findAllEvents.setup();

    runZonedSync(() {
      viewModel.loadFeed();
      container.futureRunner.advanceUntilIdle();
    });

    verify(container.findAllEvents()).called(1);
    verifyNever(container.performLogout());
    verify(container.uiStateObserver(FeedState.loading)).called(1);
    verify(
      container.uiStateObserver(
        FeedStateFeedSuccessfulLoaded(
          eventHeads: EventsFixture.allEventHeadViews,
        ),
      ),
    ).called(1);
  }

  void case2() {
    container.findAllEvents.setup(exception: Exception());

    runZonedSync(() {
      viewModel.loadFeed();
      container.futureRunner.advanceUntilIdle();
    });

    verify(container.findAllEvents()).called(1);
    verifyNever(container.performLogout());
    verify(container.uiStateObserver(FeedState.loading)).called(1);
    verify(container.uiStateObserver(FeedState.notLoaded)).called(1);
  }

  void case3() {
    container.findEventDetails.setup();
    runZonedSync(() {
      viewModel.findDetails(id: "xxx");
      container.futureRunner.advanceUntilIdle();
    });

    verify(container.findEventDetails(id: anyNamed("id"))).called(1);
    verifyNever(container.performLogout());
    verify(container.uiStateObserver(FeedState.loading)).called(1);
    verify(
      container.uiStateObserver(
        FeedStateEventDetailsSuccessfulLoaded(
          eventDetails: EventsFixture.allEventDetailsView,
        ),
      ),
    ).called(1);
  }

  void case4() {
    container.findEventDetails.setup(exception: Exception());
    runZonedSync(() {
      viewModel.findDetails(id: "xxx");
      container.futureRunner.advanceUntilIdle();
    });

    verify(container.findEventDetails(id: anyNamed("id"))).called(1);
    verifyNever(container.performLogout());
    verify(container.uiStateObserver(FeedState.loading)).called(1);
    verify(
      container.uiStateObserver(
        const FeedStateEventDetailsNotLoaded(id: "xxx"),
      ),
    ).called(1);
  }
}
