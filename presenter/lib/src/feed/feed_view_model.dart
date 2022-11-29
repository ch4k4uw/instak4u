import 'package:core/common.dart';
import 'package:injectable/injectable.dart';

import '../common/interaction/event_details_view.dart';
import '../common/uc/perform_logout.dart';
import 'interaction/event_head_view.dart';
import 'interaction/feed_state.dart';
import 'uc/find_all_events.dart';
import 'uc/find_event_details.dart';

abstract class FeedViewModel extends AppViewModel<FeedState> {
  factory FeedViewModel({
    FutureRunner? futureRunner,
    required FindAllEvents findAllEvents,
    required FindEventDetails findEventDetails,
    required PerformLogout performLogout,
  }) = FeedViewModelImpl;

  void loadFeed();

  void findDetails({required String id});

  void logout();
}

@Injectable(as: FeedViewModel)
class FeedViewModelImpl extends AppBaseViewModel<FeedState>
    implements FeedViewModel {
  final FindAllEvents _findAllEvents;
  final FindEventDetails _findEventDetails;
  final PerformLogout _performLogout;

  FeedViewModelImpl({
    FutureRunner? futureRunner,
    required FindAllEvents findAllEvents,
    required FindEventDetails findEventDetails,
    required PerformLogout performLogout,
  })  : _findAllEvents = findAllEvents,
        _findEventDetails = findEventDetails,
        _performLogout = performLogout,
        super(futureRunner: futureRunner);

  @override
  void loadFeed() {
    runFutureOrCatch(
      () async {
        send(FeedState.loading);
        final events = await _findAllEvents();
        for (var element in events) {
          print(element.image);
        }
        send(
          FeedStateFeedSuccessfulLoaded(eventHeads: events.asEventHeadViews),
        );
      },
      () async => send(FeedState.notLoaded),
    );
  }

  @override
  void findDetails({required String id}) {
    runFutureOrCatch(
      () async {
        send(FeedState.loading);
        final event = await _findEventDetails(id: id);
        send(
          FeedStateEventDetailsSuccessfulLoaded(
            eventDetails: event.asEventDetailsView,
          ),
        );
      },
      () async => send(FeedStateEventDetailsNotLoaded(id: id)),
    );
  }

  @override
  void logout() {
    runFuture(() async {
      send(FeedState.loading);
      await _performLogout();
      send(FeedState.successfulLoggedOut);
    });
  }
}
