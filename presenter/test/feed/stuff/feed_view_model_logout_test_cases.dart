import 'package:mockito/mockito.dart';
import 'package:presenter/src/feed/interaction/feed_state.dart';

import '../../common/extensions/zone_extensions.dart';
import 'feed_view_mode_test_container.dart';
import 'feed_view_model_test_cases.dart';

class FeedViewModelLogoutTestCases extends FeedViewModelTestCases {
  FeedViewModelLogoutTestCases({
    required FeedViewModelTestContainer container,
  }) : super(container: container);

  void case1() {
    runZonedSync(() {
      viewModel.logout();
      container.futureRunner.advanceUntilIdle();
    });

    verifyNever(container.findAllEvents());
    verify(container.performLogout()).called(1);
    verify(container.uiStateObserver(FeedState.loading)).called(1);
    verify(container.uiStateObserver(FeedState.successfulLoggedOut)).called(1);
  }
}
