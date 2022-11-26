import 'package:core/common.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/src/common/uc/share_event.dart';

import '../common/interaction/event_details_view.dart';
import '../common/uc/perform_logout.dart';
import 'interaction/event_details_state.dart';
import 'uc/perform_check_in.dart';

abstract class EventDetailsViewModel extends AppViewModel<EventDetailsState> {
  factory EventDetailsViewModel({
    FutureRunner? futureRunner,
    required EventDetailsView eventDetails,
    required PerformCheckIn performCheckIn,
    required ShareEvent shareEvent,
    required PerformLogout performLogout,
  }) = EventDetailsViewModelImpl;

  void performCheckIn();

  void shareEvent();

  void logout();
}

@Injectable(as: EventDetailsViewModel)
class EventDetailsViewModelImpl extends AppBaseViewModel<EventDetailsState>
    implements EventDetailsViewModel {
  final EventDetailsView _eventDetails;
  final PerformCheckIn _performCheckIn;
  final ShareEvent _shareEvent;
  final PerformLogout _performLogout;

  EventDetailsViewModelImpl({
    FutureRunner? futureRunner,
    required EventDetailsView eventDetails,
    required PerformCheckIn performCheckIn,
    required ShareEvent shareEvent,
    required PerformLogout performLogout,
  })  : _eventDetails = eventDetails,
        _performCheckIn = performCheckIn,
        _shareEvent = shareEvent,
        _performLogout = performLogout,
        super(futureRunner: futureRunner) {
    runFuture(() async {
      send(EventDetailsStateDisplayDetails(eventDetails: eventDetails));
    });
  }

  @override
  void performCheckIn() {
    runFutureOrCatch(
      () async {
        send(EventDetailsState.loading);
        await _performCheckIn(eventId: _eventDetails.id);
        send(EventDetailsState.successfulCheckedIn);
      },
      () async => send(EventDetailsState.notCheckedIn),
    );
  }

  @override
  void shareEvent() {
    runFutureOrCatch(
      () async {
        send(EventDetailsState.loading);
        await _shareEvent(eventId: _eventDetails.id);
      },
      () async => send(EventDetailsState.eventNotShared),
    );
  }

  @override
  void logout() {
    runFuture(() async {
      send(EventDetailsState.loading);
      await _performLogout();
      send(EventDetailsState.successfulLoggedOut);
    });
  }
}
