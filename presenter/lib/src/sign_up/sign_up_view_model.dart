import 'package:core/common.dart';
import 'package:domain/credential.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/sign_up.dart';
import 'package:presenter/src/common/interaction/user_view.dart';

import 'uc/perform_sign_up.dart';

abstract class SignUpViewModel extends AppViewModel<SignUpState> {
  factory SignUpViewModel({
    FutureRunner? futureRunner,
    required PerformSignUp performSignUp,
  }) = SignUpViewModelImpl;

  void signUp({
    required String name,
    required String email,
    required String password,
  });
}

@Injectable(as: SignUpViewModel)
class SignUpViewModelImpl extends AppBaseViewModel<SignUpState>
    implements SignUpViewModel {
  final PerformSignUp _performSignUp;

  SignUpViewModelImpl({
    FutureRunner? futureRunner,
    required PerformSignUp performSignUp,
  })  : _performSignUp = performSignUp,
        super(futureRunner: futureRunner);

  @override
  void signUp({
    required String name,
    required String email,
    required String password,
  }) {
    runFuture(() async {
      send(SignUpState.loading);
      try {
        final user = await _performSignUp(
          name: name,
          email: email,
          password: password,
        );
        send(SignUpStateUserSuccessfulSignedUp(user: user.asView));
      } catch (e) {
        debugPrint(e.toString());
        send(
          SignUpStateUserNotSignedUp(
            invalidName: e == appInvalidNameException,
            invalidEmail: e == appInvalidEmailException,
            duplicatedEmail: e == appDuplicatedUserException,
            invalidPassword: e == appInvalidPasswordException,
          ),
        );
      }
    });
  }
}
