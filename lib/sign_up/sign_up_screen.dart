import 'dart:async';

import 'package:core/common.dart';
import 'package:core/ui.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';
import 'package:instak4u/sign_up/sign_up_screen_state.dart';
import 'package:presenter/common.dart';
import 'package:presenter/sign_up.dart';

import '../generated/l10n.dart';

class SignUpScreen extends StatefulWidget {
  final SignUpViewModel? viewModel;
  final void Function(UserView)? onSignedUp;
  final void Function()? onNavigateBack;

  const SignUpScreen({
    Key? key,
    this.viewModel,
    this.onSignedUp,
    this.onNavigateBack,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late StreamController<_SignUpStateState>? _streamController;
  late SignUpScreenState _screenState;

  Stream<_SignUpStateState> get state => _streamController?.stream ?? _idle;

  @override
  Widget build(BuildContext context) {
    final nameError = _screenState.showInvalidNameError
        ? context.appString.signUpInvalidNameErrorPrompt
        : null;
    final emailError = _screenState.showInvalidEmailError
        ? context.appString.signUpInvalidEmailErrorPrompt
        : _screenState.showDuplicatedEmailError
            ? context.appString.signUpDuplicatedEmailErrorPrompt
            : null;
    final passwordError = _screenState.showInvalidPasswordError
        ? context.appString.signUpInvalidPasswordErrorPrompt
        : _screenState.showPasswordMatchError
            ? context.appString.signUpPasswordsMustMatchErrorPrompt
            : null;

    return AppMaterialBackground(
      child: AppContentLoadingProgressBar(
        showProgress: _screenState.showLoading,
        child: _SignInScreenHeader(
          onNavigateBack: widget.onNavigateBack,
          children: [
            _SignUpScreenFormTextField.content(
              controller: _screenState.nameController,
              keyboardType: TextInputType.text,
              hint: context.appString.nameHint,
              error: nameError,
              isAddMarginTop: true,
            ),
            _SignUpScreenFormTextField.content(
              controller: _screenState.emailController,
              keyboardType: TextInputType.emailAddress,
              hint: context.appString.emailHint,
              error: emailError,
            ),
            _SignUpScreenFormTextField.content(
              controller: _screenState.password1Controller,
              keyboardType: TextInputType.text,
              isPasswordField: true,
              hint: context.appString.passwordHint,
              error: passwordError,
            ),
            _SignUpScreenFormTextField.submit(
              controller: _screenState.password2Controller,
              keyboardType: TextInputType.text,
              isPasswordField: true,
              onSubmitted: _handleOnSubmitted,
              hint: context.appString.passwordHint,
              error: passwordError,
            ),
            _SignUpScreenSubmitButton(
              onSubmitted: _handleOnSubmitted,
            ),
          ],
        ),
      ),
    );
  }

  void _handleOnSubmitted() {
    final psw1 = _screenState.password1Controller.text;
    final psw2 = _screenState.password2Controller.text;
    if (psw1 == psw2) {
      widget.viewModel?.signUp(
        name: _screenState.nameController.text,
        email: _screenState.emailController.text,
        password: _screenState.password1Controller.text,
      );
    } else {
      setState(() => _screenState.showPasswordMatchError = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _setupState();
    _setupListeners();
  }

  void _setupState() {
    void hideNameErrors() {
      setState(() => _screenState.showInvalidNameError = false);
    }

    void hideEmailErrors() {
      setState(() {
        _screenState.showInvalidEmailError = false;
        _screenState.showDuplicatedEmailError = false;
      });
    }

    void hidePasswordErrors() {
      setState(() {
        _screenState.showInvalidPasswordError = false;
        _screenState.showPasswordMatchError = false;
      });
    }

    _screenState = SignUpScreenState(
      onSuccessfulSignedUp: (user) => widget.onSignedUp?.call(user),
    )
      ..nameController.addListener(() => hideNameErrors())
      ..emailController.addListener(() => hideEmailErrors())
      ..password1Controller.addListener(() => hidePasswordErrors())
      ..password2Controller.addListener(() => hidePasswordErrors());

    _streamController = widget.viewModel?.let((it) {
      final result = StreamController<_SignUpStateState>();
      it.uiState.listen((event) {
        result.add(_SignUpStateStateChangeState(newState: event));
      });
      return result;
    });
  }

  void _setupListeners() {
    state.listen((event) {
      if (event is _SignUpStateStateChangeState) {
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

final _idle = Stream.value(_SignUpStateState.idle);

abstract class _SignUpStateState {
  static const _SignUpStateState idle = _ConstStateState();
}

class _ConstStateState implements _SignUpStateState {
  const _ConstStateState();
}

class _SignUpStateStateChangeState implements _SignUpStateState {
  final SignUpState newState;

  const _SignUpStateStateChangeState({required this.newState});
}

class _SignInScreenHeader extends StatelessWidget {
  final void Function()? onNavigateBack;
  final List<Widget> children;

  const _SignInScreenHeader({required this.children, this.onNavigateBack});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SafeArea(
      child: AppContentLoadingProgressBar(
        child: Column(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () => onNavigateBack?.call(),
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(S.of(context).appName),
            ),
            Flexible(
              /// https://stackoverflow.com/questions/56326005/how-to-use-expand
              /// ed-in-singlechildscrollview
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.dimens.spacing.xxnormal,
                          ),
                          child: Column(children: children),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpScreenFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hint;
  final String? error;
  final bool isPasswordField;
  final bool isAddMarginTop;
  final void Function()? onSubmitted;
  final bool _isLastField;

  const _SignUpScreenFormTextField.content({
    required this.controller,
    required this.keyboardType,
    required this.hint,
    this.error,
    this.isPasswordField = false,
    this.isAddMarginTop = false,
  })  : onSubmitted = null,
        _isLastField = false;

  const _SignUpScreenFormTextField.submit({
    required this.controller,
    required this.keyboardType,
    required this.hint,
    this.error,
    required this.onSubmitted,
    this.isPasswordField = false,
  })  : isAddMarginTop = false,
        _isLastField = true;

  @override
  Widget build(BuildContext context) {
    final dimens = AppTheme.of(context).dimens.spacing;
    return Column(
      children: [
        SizedBox(height: isAddMarginTop ? dimens.xxnormal : dimens.tiny),
        TextFormField(
          controller: controller,
          autocorrect: false,
          keyboardType: keyboardType,
          textInputAction:
              _isLastField ? TextInputAction.send : TextInputAction.next,
          obscureText: isPasswordField,
          onFieldSubmitted: (_) => onSubmitted?.call(),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: hint,
            helperText: error == null ? " " : null,
            filled: true,
            errorText: error,
          ),
        )
      ],
    );
  }
}

class _SignUpScreenSubmitButton extends StatelessWidget {
  final void Function() onSubmitted;

  const _SignUpScreenSubmitButton({required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Expanded(
      child: Column(
        children: [
          Expanded(child: Container()),
          AppHorizontalExpanded(
            child: ElevatedButton(
              onPressed: onSubmitted,
              child: Text(S.of(context).submitAction),
            ),
          ),
          SizedBox(height: theme.dimens.spacing.xxnormal)
        ],
      ),
    );
  }
}
