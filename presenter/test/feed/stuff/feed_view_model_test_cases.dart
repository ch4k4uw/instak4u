import 'package:core/common.dart';
import 'package:mockito/mockito.dart';
import 'package:presenter/src/feed/feed_view_model.dart';

import '../../common/extensions/perform_logout_extensions.dart';
import '../feed_view_model_test.mocks.dart';
import 'events_fixture.dart';
import 'feed_view_mode_test_container.dart';

class FeedViewModelTestCases {
  final FeedViewModelTestContainer container;
  final FeedViewModel viewModel;

  FeedViewModelTestCases({required this.container})
      : viewModel = FeedViewModel(
          futureRunner: container.futureRunner,
          findAllEvents: container.findAllEvents,
          findEventDetails: container.findEventDetails,
          performLogout: container.performLogout,
        ) {
    viewModel.uiState.listen(
      container.uiStateObserver,
    );
    container.performLogout.setup();
  }
}

extension FindAllEventsExtensions on MockFindAllEvents {
  void setup({Exception? exception}) {
    when(call()).thenAnswer((realInvocation) {
      if (exception != null) {
        return Future.error(exception, StackTrace.current);
      }
      return EventsFixture.allEvents.asSynchronousFuture;
    });
  }
}
