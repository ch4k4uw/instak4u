import 'dart:async';

import 'package:core/common.dart';
import 'package:core/ui.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/feed/component/feed_screen_content.dart';
import 'package:instak4u/feed/feed_screen_state.dart';
import 'package:presenter/common.dart';
import 'package:presenter/feed.dart';

class FeedScreen extends StatefulWidget {
  final bool asPreview;
  final FeedViewModel? viewModel;
  final UserView? userView;
  final Function(EventDetailsView)? onShowEventDetails;
  final void Function()? onLoggedOut;
  final void Function()? onNavigateBack;

  const FeedScreen({
    Key? key,
    this.viewModel,
    this.userView,
    this.onShowEventDetails,
    this.onLoggedOut,
    this.onNavigateBack,
  })  : asPreview = false,
        super(key: key);

  const FeedScreen.preview({
    Key? key,
  })  : viewModel = null,
        userView = null,
        onShowEventDetails = null,
        onLoggedOut = null,
        onNavigateBack = null,
        asPreview = true,
        super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

final _idle = Stream.value(_FeedStateState.idle);

abstract class _FeedStateState {
  static _FeedStateState idle = _ConstStateState();
}

class _ConstStateState implements _FeedStateState {}

class _FeedStateStateChangeState implements _FeedStateState {
  final FeedState newState;

  const _FeedStateStateChangeState({required this.newState});
}

class _FeedScreenState extends State<FeedScreen> {
  late FeedScreenState _screenState;
  late StreamController<_FeedStateState>? _streamController;

  Stream<_FeedStateState> get state => _streamController?.stream ?? _idle;

  bool _loadFeed = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Material(
      color: theme.colors.colorScheme.background,
      child: SafeArea(child: _showScreen()),
    );
  }

  Widget _showScreen() {
    return AppContentLoadingProgressBar(
      showProgress: _screenState.showProgress,
      child: FeedScreenContent(
        events: _screenState.events,
        userView: widget.userView.orEmpty(),
        onFindEventDetails: (id) => widget.viewModel?.findDetails(id: id),
        onLogout: () => widget.viewModel?.logout(),
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
    _setupState();
    _setupListeners();
    if (_loadFeed) {
      _loadFeed = false;
      widget.viewModel?.loadFeed();
    }
  }

  void _setupState() {
    _screenState = FeedScreenState(
      onShowEventDetails: widget.onShowEventDetails,
      onLoggedOut: widget.onLoggedOut,
      onError: _onError,
    );
    _streamController = widget.viewModel?.let((it) {
      final result = StreamController<_FeedStateState>();
      it.uiState.listen((event) {
        result.add(_FeedStateStateChangeState(newState: event));
      });
      return result;
    });
  }

  void _onError(FeedState state) {
    context.showModalGenericErrorBottomSheet(onPositiveClick: () {
      if (state is FeedStateEventDetailsNotLoaded) {
        widget.viewModel?.findDetails(id: state.id);
      } else {
        widget.viewModel?.loadFeed();
      }
      return true;
    });
  }

  void _setupListeners() {
    state.listen((event) {
      if (event is _FeedStateStateChangeState) {
        setState(() {
          _screenState.handleState(state: event.newState);
        });
      }
    });
  }
}
