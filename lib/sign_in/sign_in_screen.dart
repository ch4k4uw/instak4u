import 'dart:async';

import 'package:core/common/extensions/build_context_extensions.dart';
import 'package:core/common/extensions/object_extensions.dart';
import 'package:core/ui/app_theme.dart';
import 'package:core/ui/component/app_content_loading_progress_bar.dart';
import 'package:core/ui/component/app_horizontal_expanded.dart';
import 'package:core/ui/component/app_material_background.dart';
import 'package:core/ui/component/app_modal_warning_bottom_sheet_type.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';
import 'package:instak4u/sign_in/sigin_in_constants.dart';
import 'package:instak4u/sign_in/sign_in_screen_state.dart';
import 'package:presenter/common.dart';
import 'package:presenter/sign_in.dart';

class SignInScreen extends StatefulWidget {
  final SignInViewModel? viewModel;
  final void Function(UserView)? onSignedIn;
  final void Function()? onNavigateToSignUp;

  const SignInScreen({
    Key? key,
    this.viewModel,
    this.onSignedIn,
    this.onNavigateToSignUp,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late StreamController<_SignInStateState>? _streamController;
  late SignInScreenState _screenState;

  Stream<_SignInStateState> get state => _streamController?.stream ?? _idle;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppMaterialBackground(
      child: AppContentLoadingProgressBar(
        showProgress: _screenState.showLoading,
        child: _SignInScreenHeader(
          children: [
            _SignInScreenFormTextFields(
              emailController: _screenState.email,
              passwordController: _screenState.password,
              onSubmitted: _handleOnSubmitted,
            ),
            SizedBox(height: theme.dimens.spacing.normal),
            _SignInScreenFormButtons(
              onSignIn: _handleOnSubmitted,
              onNavigateToSignUp: _handleNavigateToSignUp,
            ),
          ],
        ),
      ),
    );
  }

  void _handleOnSubmitted() {
    FocusManager.instance.primaryFocus?.unfocus();
    widget.viewModel?.signIn(
      email: _screenState.email.text,
      password: _screenState.password.text,
    );
  }

  void _handleNavigateToSignUp() {
    FocusManager.instance.primaryFocus?.unfocus();
    widget.onNavigateToSignUp?.call();
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
    _screenState = SignInScreenState(
      onSignedIn: (user) => widget.onSignedIn?.call(user),
      onAlreadySignedIn: (user) => widget.onSignedIn?.call(user),
      onNotSignedIn: _showNotSignInError,
    );
    _streamController = widget.viewModel?.let((it) {
      final result = StreamController<_SignInStateState>();
      it.uiState.listen((event) {
        result.add(_SignInStateStateChangeState(newState: event));
      });
      return result;
    });
  }

  void _showNotSignInError() {
    final positiveButtonLabel =
        context.appString.signInInvalidUserOrPassErrorPositiveAction;

    context.showAppModalWarningBottomSheet(
      type: AppModalWarningBottomSheetType.error,
      title: context.appString.signInInvalidUserOrPassErrorTitle,
      message: context.appString.signInInvalidUserOrPassErrorDescription,
      positiveButtonLabel: positiveButtonLabel,
    );
  }

  void _setupListeners() {
    state.listen((event) {
      if (event is _SignInStateStateChangeState) {
        setState(() => _screenState.handleState(state: event.newState));
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

final _idle = Stream.value(_SignInStateState.idle);

abstract class _SignInStateState {
  static const _SignInStateState idle = _ConstStateState();
}

class _ConstStateState implements _SignInStateState {
  const _ConstStateState();
}

class _SignInStateStateChangeState implements _SignInStateState {
  final SignInState newState;

  const _SignInStateStateChangeState({required this.newState});
}

class _SignInScreenHeader extends StatelessWidget {
  final List<Widget> children;

  const _SignInScreenHeader({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: SignInConstants.avatarTopWeight,
          child: Container(),
        ),
        Flexible(
          flex: SignInConstants.avatarContentPanelWeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Icon(
                    Icons.person,
                    color: theme.colors.colorScheme.onSurface.withOpacity(.12),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    SizedBox(height: theme.dimens.spacing.xtiny),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.dimens.spacing.xxnormal,
                      ),
                      child: AppHorizontalExpanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return FractionallySizedBox(
                              widthFactor: (constraints.maxWidth.isLarge
                                  ? constraints.maxWidth.largeFactor
                                  : 1),
                              child: Column(children: children),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignInScreenFormTextFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function() onSubmitted;

  const _SignInScreenFormTextFields({
    required this.emailController,
    required this.passwordController,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          autocorrect: false,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: context.appString.emailHint,
            filled: true,
          ),
        ),
        SizedBox(height: theme.dimens.spacing.normal),
        TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.send,
          obscureText: true,
          onFieldSubmitted: (_) => onSubmitted(),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: context.appString.passwordHint,
            filled: true,
          ),
        ),
      ],
    );
  }
}

class _SignInScreenFormButtons extends StatelessWidget {
  final void Function() onSignIn;
  final void Function() onNavigateToSignUp;

  const _SignInScreenFormButtons({
    required this.onSignIn,
    required this.onNavigateToSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHorizontalExpanded(
          child: ElevatedButton(
            onPressed: onSignIn,
            child: Text(context.appString.signInAction),
          ),
        ),
        AppHorizontalExpanded(
          child: OutlinedButton(
            onPressed: onNavigateToSignUp,
            child: Text(context.appString.registerAction),
          ),
        ),
      ],
    );
  }
}
