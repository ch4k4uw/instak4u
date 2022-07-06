import 'package:core/common/extensions/build_context_extensions.dart';
import 'package:core/common/extensions/object_extensions.dart';
import 'package:core/ui/app_theme.dart';
import 'package:core/ui/component/app_content_loading_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/feed/component/feed_screen_content.dart';
import 'package:instak4u/feed/feed_preview_screen.dart';
import 'package:instak4u/feed/feed_screen_state.dart';
import 'package:presenter/common.dart';
import 'package:presenter/feed.dart';

class FeedScreen extends StatelessWidget {
  final bool asPreview;

  const FeedScreen({Key? key})
      : asPreview = false,
        super(key: key);

  const FeedScreen.preview({Key? key})
      : asPreview = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Material(
      color: theme.colors.colorScheme.background,
      child: SafeArea(child: asPreview ? _preview() : _FeedScreen()),
    );
  }

  Widget _preview() {
    return FeedPreviewScreen(
      builder: (user, events) {
        final feedState = FeedStateFeedSuccessfulLoaded(eventHeads: events);
        return _FeedScreen(
          state: Stream.value(_FeedStateStateChangeState(newState: feedState)),
          userView: user,
          onShowEventDetails: (event) {
            debugPrint("Show details to \"${event.title}\" event.");
          },
          onLoggedOut: () {
            debugPrint("Successful logged-out");
          },
          onNavigateBack: () {
            debugPrint("Perform back-navigation.");
          },
          onIntent: (intent) {
            debugPrint("Intention received: ${intent.runtimeType}");
          },
        );
      },
    );
  }
}

class _FeedScreen extends StatefulWidget {
  final Stream<_FeedStateState> state;
  final UserView userView;
  final void Function(EventDetailsView)? onShowEventDetails;
  final void Function()? onLoggedOut;
  final void Function()? onNavigateBack;
  final void Function(_FeedIntent)? onIntent;

  _FeedScreen({
    Key? key,
    Stream<_FeedStateState>? state,
    this.userView = UserView.empty,
    this.onShowEventDetails,
    this.onLoggedOut,
    this.onNavigateBack,
    this.onIntent,
  })  : state = state ?? Stream.value(_FeedStateState.idle),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedScreenState();
}

abstract class _FeedStateState {
  static const _FeedStateState idle = _ConstStateState();
}

class _ConstStateState implements _FeedStateState {
  const _ConstStateState();
}

class _FeedStateStateChangeState implements _FeedStateState {
  final FeedState newState;

  const _FeedStateStateChangeState({required this.newState});
}

abstract class _FeedIntent {
  static final _FeedIntent load = _ConstIntent();
  static final _FeedIntent logout = _ConstIntent();
}

class _ConstIntent extends _FeedIntent {}

class _FeedIntentFindDetails implements _FeedIntent {
  final String id;

  const _FeedIntentFindDetails({required this.id});
}

class _FeedScreenState extends State<_FeedScreen> {
  late FeedScreenState _screenState;

  @override
  Widget build(BuildContext context) {
    return AppContentLoadingProgressBar(
      showProgress: _screenState.showProgress,
      child: FeedScreenContent(
        events: _screenState.events,
        userView: widget.userView,
        onFindEventDetails: (id) => widget.onIntent?.call(
          _FeedIntentFindDetails(id: id),
        ),
        onLogout: () => widget.onIntent?.call(_FeedIntent.logout),
        onNavigateBack: widget.onNavigateBack,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    AppThemeController.of(context)?.resetSystemUiOverlayStyle(
      updateSystemChrome: true,
    );
    widget.state.listen((event) {
      if (event is _FeedStateStateChangeState) {
        setState(() {
          _screenState.handleState(state: event.newState);
        });
      }
    });
    _screenState = FeedScreenState(
      onShowEventDetails: widget.onShowEventDetails,
      onLoggedOut: widget.onLoggedOut,
      onError: _onError,
    );
  }

  void _onError(FeedState state) {
    context.showModalGenericErrorBottomSheet(
      onPositiveClick: () {
        final _FeedIntent intent = state.let((it) {
          if (it is FeedStateEventDetailsNotLoaded) {
            return _FeedIntentFindDetails(id: it.id);
          }
          return _FeedIntent.load;
        });
        widget.onIntent?.call(intent);
        return true;
      }
    );
  }
}
