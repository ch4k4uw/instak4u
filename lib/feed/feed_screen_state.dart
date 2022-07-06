import 'package:presenter/common.dart';
import 'package:presenter/feed.dart';

class FeedScreenState {
  final void Function(EventDetailsView)? onShowEventDetails;
  final void Function()? onLoggedOut;
  final void Function(FeedState)? onError;
  bool _showProgress = false;

  bool get showProgress => _showProgress;
  List<EventHeadView> _events = List.empty();

  List<EventHeadView> get events => _events;

  FeedScreenState({
    required this.onShowEventDetails,
    required this.onLoggedOut,
    required this.onError,
  });

  void handleState({required FeedState state}) {
    _showProgress = state == FeedState.loading;
    if (state is FeedStateFeedSuccessfulLoaded) {
      _events = state.eventHeads;
    } else if (state == FeedState.successfulLoggedOut) {
      onLoggedOut?.call();
    } else if (state is FeedStateEventDetailsSuccessfulLoaded) {
      onShowEventDetails?.call(state.eventDetails);
    } else {
      if (state.isError) {
        onError?.call(state);
      }
    }
  }
}
