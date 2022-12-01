import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presenter/sign_in.dart';
import 'package:presenter/src/common/uc/find_logged_user.dart';
import 'package:presenter/src/sign_in/uc/perform_sign_in.dart';

import '../common/extensions/find_logged_user_extensions.dart';
import '../common/extensions/perform_sign_in_extensions.dart';
import '../common/extensions/zone_extensions.dart';
import '../common/stuff/common_fixture.dart';
import '../ui_state_observer.dart';
import '../unawaited_future_runner.dart';
@GenerateNiceMocks([MockSpec<FindLoggedUser>()])
@GenerateNiceMocks([MockSpec<PerformSignIn>()])
@GenerateNiceMocks([MockSpec<UiStateObserver<SignInState>>()])
import 'sign_in_view_model_test.mocks.dart';

void main() {
  final findLoggedUser = MockFindLoggedUser();
  final performSignIn = MockPerformSignIn();
  final futureRunner = UnawaitedFutureRunner();
  final uiStateObserver = MockUiStateObserver();

  late SignInViewModel vm;

  setUp(() {
    vm = SignInViewModel(
      futureRunner: futureRunner,
      findLoggedUser: findLoggedUser,
      performSignIn: performSignIn,
    );
    vm.uiState.listen(uiStateObserver);

    _disableLog();
  });

  group('sign-in', () {
    test('it should perform the sign-in', () async {
      findLoggedUser.setup();
      performSignIn.setup();

      runZonedSync(() {
        futureRunner.advanceUntilIdle();
        vm.signIn(email: "", password: "");
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignInState.loading),
        findLoggedUser(),
        uiStateObserver(SignInState.loaded),
        uiStateObserver(SignInState.loading),
        performSignIn(
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
        uiStateObserver(
          SignInStateUserSuccessfulSignedIn(
            user: CommonFixture.presenter.user,
          ),
        ),
      ]);
    });

    test('it should change to already logged in state', () async {
      findLoggedUser.setup(hasLoggedUser: true);
      performSignIn.setup();

      runZonedSync(() {
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignInState.loading),
        findLoggedUser(),
        uiStateObserver(
          SignInStateUserAlreadyLoggedIn(
            user: CommonFixture.presenter.user,
          ),
        ),
      ]);
    });

    test('it shouldn\'t perform the sign-in', () async {
      findLoggedUser.setup();
      performSignIn.setup(exception: Exception());

      runZonedSync(() {
        futureRunner.advanceUntilIdle();
        vm.signIn(email: "", password: "");
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignInState.loading),
        findLoggedUser(),
        uiStateObserver(SignInState.loaded),
        uiStateObserver(SignInState.loading),
        performSignIn(
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
        uiStateObserver(
          SignInState.userNotSignedIn,
        ),
      ]);
    });
  });
}

void _disableLog() {
  debugPrint = (String? message, {int? wrapWidth}) {};
}