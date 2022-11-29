import '../../common/interaction/event_details_view.dart';

abstract class EventDetailsState {
  static final EventDetailsState loading = _ConstState();
  static final EventDetailsState successfulCheckedIn = _ConstState();
  static final EventDetailsState successfulLoggedOut = _ConstState();
  static final EventDetailsState notCheckedIn = _ConstState();
  static final EventDetailsState eventNotShared = _ConstState();
  const EventDetailsState();
  bool get isError {
    return this == notCheckedIn || this == eventNotShared;
  }
}

class _ConstState extends EventDetailsState {
  _ConstState();
}

class EventDetailsStateDisplayDetails extends EventDetailsState {
  final EventDetailsView eventDetails;

  const EventDetailsStateDisplayDetails({required this.eventDetails});
}

class EventDetailsStateShareEvent extends EventDetailsState {
  final String text;

  const EventDetailsStateShareEvent({required this.text});
}

