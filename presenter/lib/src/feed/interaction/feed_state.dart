import 'package:flutter/foundation.dart';

import '../../common/interaction/event_details_view.dart';
import 'event_head_view.dart';

abstract class FeedState {
  static final FeedState loading = _ConstState();
  static final FeedState notLoaded = _ConstState();
  static final FeedState successfulLoggedOut = _ConstState();

  const FeedState();

  bool get isError {
    return this == notLoaded || this is FeedStateEventDetailsNotLoaded;
  }
}

class _ConstState extends FeedState {}

class FeedStateFeedSuccessfulLoaded extends FeedState {
  final List<EventHeadView> eventHeads;

  FeedStateFeedSuccessfulLoaded({required List<EventHeadView> eventHeads})
      : eventHeads = List.unmodifiable(eventHeads);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedStateFeedSuccessfulLoaded &&
          runtimeType == other.runtimeType &&
          listEquals(eventHeads, other.eventHeads);

  @override
  int get hashCode => eventHeads.hashCode;
}

class FeedStateEventDetailsSuccessfulLoaded extends FeedState {
  final EventDetailsView eventDetails;

  const FeedStateEventDetailsSuccessfulLoaded({required this.eventDetails});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedStateEventDetailsSuccessfulLoaded &&
          runtimeType == other.runtimeType &&
          eventDetails == other.eventDetails;

  @override
  int get hashCode => eventDetails.hashCode;
}

class FeedStateEventDetailsNotLoaded extends FeedState {
  final String id;

  const FeedStateEventDetailsNotLoaded({required this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedStateEventDetailsNotLoaded &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
