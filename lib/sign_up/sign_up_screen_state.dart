import 'package:flutter/material.dart';
import 'package:presenter/common.dart';
import 'package:presenter/sign_up.dart';

class SignUpScreenState {
  final void Function(UserView) onSuccessfulSignedUp;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  bool showLoading = false;
  bool showInvalidNameError = false;
  bool showInvalidEmailError = false;
  bool showDuplicatedEmailError = false;
  bool showInvalidPasswordError = false;
  bool showPasswordMatchError = false;

  SignUpScreenState({required this.onSuccessfulSignedUp});

  void handleState({required SignUpState state}) {
    showLoading = state == SignUpState.loading;
    if (state is SignUpStateUserSuccessfulSignedUp) {
      onSuccessfulSignedUp(state.user);
    } else if (state is SignUpStateUserNotSignedUp) {
      showInvalidNameError = state.invalidName;
      showInvalidEmailError = state.invalidEmail;
      showDuplicatedEmailError = state.duplicatedEmail;
      showInvalidPasswordError = state.invalidPassword;
    }
  }

  bool assertPasswordMatch({
    required String password1,
    required String password2,
  }) =>
      showPasswordMatchError = !(password1 == password2);
}
