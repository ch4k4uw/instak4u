import 'package:core/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presenter/sign_in.dart';
import 'package:presenter/src/common/uc/find_logged_user.dart';
import 'package:presenter/src/sign_in/uc/perform_sign_in.dart';

import '../common/extensions/find_logged_user_extensions.dart';
import '../common/extensions/global_extensions.dart';
import '../common/extensions/zone_extensions.dart';
import '../common/stuff/common_fixture.dart';
import '../ui_state_observer.dart';
import '../unawaited_future_runner.dart';
@GenerateNiceMocks([
  MockSpec<FindLoggedUser>(),
  MockSpec<PerformSignIn>(),
  MockSpec<UiStateObserver<SignInState>>(),
])
import 'sign_in_view_model_test.mocks.dart';

void main() {
  final uiStateObserver = MockUiStateObserver();
  final futureRunner = UnawaitedFutureRunner();
  final findLoggedUser = MockFindLoggedUser();
  final performSignIn = MockPerformSignIn();

  late SignInViewModel vm;

  setUp(() {
    vm = SignInViewModel(
      futureRunner: futureRunner,
      findLoggedUser: findLoggedUser,
      performSignIn: performSignIn,
    )..uiState.listen(uiStateObserver);

    disableLog();
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

extension SignInVMMockPerformSignInExtensions on MockPerformSignIn {
  void setup({Exception? exception}) {
    when(
      this(email: anyNamed("email"), password: anyNamed("password")),
    ).thenAnswer(
      (realInvocation) {
        if (exception != null) {
          return Future.error(exception, StackTrace.current);
        }
        return CommonFixture.domain.user.asSynchronousFuture;
      },
    );
  }
}
