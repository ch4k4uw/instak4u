import 'dart:async';

import 'package:core/common/extensions/build_context_extensions.dart';
import 'package:core/common/extensions/object_extensions.dart';
import 'package:core/ui/app_theme.dart';
import 'package:core/ui/component/app_material_background.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';
import 'package:presenter/common.dart';
import 'package:presenter/splash.dart';

class SplashScreenScreen extends StatefulWidget {
  final SplashScreenViewModel? viewModel;
  final void Function()? onShowSignIn;
  final void Function(UserView)? onShowFeed;
  final void Function(UserView, EventDetailsView)? onShowEventDetails;

  const SplashScreenScreen({
    Key? key,
    this.viewModel,
    this.onShowSignIn,
    this.onShowFeed,
    this.onShowEventDetails,
  }) : super(key: key);

  const SplashScreenScreen.preview()
      : viewModel = null,
        onShowSignIn = null,
        onShowFeed = null,
        onShowEventDetails = null,
        super(key: null);

  @override
  State<StatefulWidget> createState() => _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
  late StreamController<_SplashScreenStateState>? _streamController;

  Stream<_SplashScreenStateState> get state =>
      _streamController?.stream ?? _idle;

  @override
  Widget build(BuildContext context) {
    return AppMaterialBackground(
      backgroundColor: context.appTheme.colors.colorScheme.primary,
      child: Column(
        children: [
          Expanded(flex: 43, child: Container()),
          Expanded(
            flex: 57,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                _AppNameText(),
                _StatusText(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    AppThemeController.of(context)?.switchSystemUiOverlayToDarkStyle(
      statusBarColor: Colors.transparent,
      updateSystemChrome: true,
    );

    _setupState();
    _setupListeners();
  }

  void _setupState() {
    _streamController = widget.viewModel?.let((it) {
      final result = StreamController<_SplashScreenStateState>();
      it.uiState.listen((event) {
        result.add(_SplashScreenStateStateChangeState(newState: event));
      });
      return result;
    });
  }

  void _setupListeners() {
    state.listen((event) {
      if (event is _SplashScreenStateStateChangeState) {
        final state = event.newState;
        if (state is SplashScreenStateShowFeedScreen) {
          widget.onShowFeed?.call(state.user);
          return;
        }
        if (state is SplashScreenStateEventDetailsSuccessfulLoaded) {
          widget.onShowEventDetails?.call(state.user, state.eventDetails);
          return;
        }
        if (state == SplashScreenState.showSignInScreen) {
          widget.onShowSignIn?.call();
          return;
        }
        if (state is SplashScreenStateNotInitialized) {
          throw state.cause;
        }
        if (state is SplashScreenStateEventDetailsNotLoaded) {
          throw state.cause;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    widget.viewModel?.close();
  }
}

final _idle = Stream.value(_SplashScreenStateState.idle);

abstract class _SplashScreenStateState {
  static const _SplashScreenStateState idle = _ConstStateState();
}

class _ConstStateState implements _SplashScreenStateState {
  const _ConstStateState();
}

class _SplashScreenStateStateChangeState implements _SplashScreenStateState {
  final SplashScreenState newState;

  const _SplashScreenStateStateChangeState({required this.newState});
}

class _AppNameText extends StatelessWidget {
  const _AppNameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final colors = context.appTheme.colors;
    return Text(
      context.appString.appName,
      style: textTheme.headline3?.copyWith(
        color: colors.colorScheme.primaryContainer,
      ),
    );
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final colors = context.appTheme.colors;
    return Text(
      context.appString.pleaseWaitPrompt,
      style: textTheme.subtitle1?.copyWith(
        color: colors.colorScheme.onPrimary,
      ),
    );
  }
}
