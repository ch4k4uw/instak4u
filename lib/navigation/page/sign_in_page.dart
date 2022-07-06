import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:instak4u/sign_in/sign_in_screen.dart';
import 'package:presenter/common.dart';
import 'package:presenter/sign_in.dart';

class SignInPage extends Page {
  final SignInViewModel viewModel;
  final void Function(UserView)? onSignedIn;
  final void Function()? onNavigateToSignUp;

  SignInPage({
    this.onSignedIn,
    this.onNavigateToSignUp,
  }) : viewModel = GetIt.I.get<SignInViewModel>(),
        super(key: const ValueKey(SignInPage));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return SignInScreen(
          viewModel: viewModel,
          onSignedIn: onSignedIn,
          onNavigateToSignUp: onNavigateToSignUp,
        );
      },
    );
  }
}
