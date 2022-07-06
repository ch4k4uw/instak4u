import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presenter/common.dart';
import 'package:presenter/sign_up.dart';

import '../../sign_up/sign_up_screen.dart';

class SignUpPage extends Page {
  final SignUpViewModel viewModel;
  final void Function(UserView)? onSignedIn;
  final void Function()? onNavigateBack;

  SignUpPage({
    this.onSignedIn,
    this.onNavigateBack,
  })  : viewModel = GetIt.I.get<SignUpViewModel>(),
        super(key: const ValueKey(SignUpPage));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return SignUpScreen(
          viewModel: viewModel,
          onSignedUp: onSignedIn,
        );
      },
    );
  }
}
