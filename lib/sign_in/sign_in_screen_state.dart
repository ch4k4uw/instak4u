import 'package:flutter/material.dart';
import 'package:presenter/common.dart';
import 'package:presenter/sign_in.dart';

class SignInScreenState {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final void Function(UserView) onSignedIn;
  final void Function(UserView) onAlreadySignedIn;
  final void Function() onNotSignedIn;
  bool showLoading = false;

  SignInScreenState({
    required this.onSignedIn,
    required this.onAlreadySignedIn,
    required this.onNotSignedIn,
  });

  void handleState({required SignInState state}) {
    showLoading = state == SignInState.loading;
    if (state is SignInStateUserAlreadyLoggedIn) {
      onAlreadySignedIn(state.user);
    } else if (state is SignInStateUserSuccessfulSignedIn) {
      onSignedIn(state.user);
    } else if (state == SignInState.userNotSignedIn) {
      onNotSignedIn();
    }
  }
}
