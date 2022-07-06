import 'package:presenter/common.dart';
import 'package:presenter/event.dart';

class EventDetailsScreenState {
  final void Function()? onLoggedOut;
  final void Function(String)? onShareEvent;
  final void Function()? onSuccessfulCheckedIn;
  final void Function(EventDetailsState)? onError;

  bool showProgress = false;

  EventDetailsView _details = const EventDetailsView();

  EventDetailsView get details => _details;

  EventDetailsScreenState({
    this.onLoggedOut,
    this.onShareEvent,
    this.onSuccessfulCheckedIn,
    this.onError,
  });

  void handleState({required EventDetailsState state}) {
    showProgress = state == EventDetailsState.loading;
    if (state is EventDetailsStateDisplayDetails) {
      _details = state.eventDetails;
    } else if (state is EventDetailsStateShareEvent) {
      onShareEvent?.call(state.text);
    } else if(state == EventDetailsState.successfulLoggedOut) {
      onLoggedOut?.call();
    } else if(state == EventDetailsState.successfulCheckedIn) {
      onSuccessfulCheckedIn?.call();
    } else {
      if (state.isError) {
        onError?.call(state);
      }
    }
  }
}
