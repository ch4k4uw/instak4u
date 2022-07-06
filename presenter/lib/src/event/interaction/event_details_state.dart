import '../../common/interaction/event_details_view.dart';

abstract class EventDetailsState {
  static const EventDetailsState loading = _ConstState();
  static const EventDetailsState successfulCheckedIn = _ConstState();
  static const EventDetailsState successfulLoggedOut = _ConstState();
  static const EventDetailsState notCheckedIn = _ConstState();
  static const EventDetailsState eventNotShared = _ConstState();
  const EventDetailsState();
  bool get isError {
    return this == notCheckedIn || this == eventNotShared;
  }
}

class _ConstState extends EventDetailsState {
  const _ConstState();
}

class EventDetailsStateDisplayDetails extends EventDetailsState {
  final EventDetailsView eventDetails;

  const EventDetailsStateDisplayDetails({required this.eventDetails});
}

class EventDetailsStateShareEvent extends EventDetailsState {
  final String text;

  const EventDetailsStateShareEvent({required this.text});
}

