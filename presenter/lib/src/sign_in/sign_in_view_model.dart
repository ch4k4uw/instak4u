import 'package:core/common.dart';
import 'package:domain/credential.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/sign_in.dart';
import 'package:presenter/src/common/interaction/user_view.dart';
import 'package:presenter/src/common/us/find_logged_user.dart';
import 'package:presenter/src/sign_in/uc/perform_sign_in.dart';

abstract class SignInViewModel extends AppViewModel<SignInState> {
  factory SignInViewModel({
    FutureRunner? futureRunner,
    required FindLoggedUser findLoggedUser,
    required PerformSignIn performSignIn,
  }) = SignInViewModelImpl;

  void signIn({required String email, required String password});
}

@Injectable(as: SignInViewModel)
class SignInViewModelImpl extends AppBaseViewModel<SignInState>
    implements SignInViewModel {
  final FindLoggedUser _findLoggedUser;
  final PerformSignIn _performSignIn;

  SignInViewModelImpl({
    FutureRunner? futureRunner,
    required FindLoggedUser findLoggedUser,
    required PerformSignIn performSignIn,
  })  : _findLoggedUser = findLoggedUser,
        _performSignIn = performSignIn,
        super(futureRunner: futureRunner) {
    runFuture(() async {
      send(await _init());
    });
  }

  Future<SignInState> _init() async {
    send(SignInState.loading);
    final user = await _findLoggedUser();
    return user == User.empty
        ? SignInState.loaded
        : SignInStateUserAlreadyLoggedIn(user: user.asView);
  }

  @override
  void signIn({required String email, required String password}) {
    runFuture(() async {
      send(SignInState.loading);
      try {
        final user = await _performSignIn(email: email, password: password);
        if (user != User.empty) {
          send(SignInStateUserSuccessfulSignedIn(user: user.asView));
        } else {
          send(SignInState.userNotSignedIn);
        }
      } catch (e) {
        debugPrint(e.toString());
        send(SignInState.userNotSignedIn);
      }
    });
  }
}
