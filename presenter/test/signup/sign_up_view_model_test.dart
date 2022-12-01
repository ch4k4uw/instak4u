import 'package:core/common.dart';
import 'package:domain/credential.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presenter/src/sign_up/interaction/sign_up_state.dart';
import 'package:presenter/src/sign_up/sign_up_view_model.dart';
import 'package:presenter/src/sign_up/uc/perform_sign_up.dart';

import '../common/extensions/global_extensions.dart';
import '../common/extensions/zone_extensions.dart';
import '../common/stuff/common_fixture.dart';
import '../ui_state_observer.dart';
import '../unawaited_future_runner.dart';
@GenerateNiceMocks([MockSpec<PerformSignUp>()])
@GenerateNiceMocks([MockSpec<UiStateObserver<SignUpState>>()])
import 'sign_up_view_model_test.mocks.dart';

final SignUpStateUserNotSignedUp emptyError = SignUpStateUserNotSignedUp(
  invalidName: false,
  invalidEmail: false,
  duplicatedEmail: false,
  invalidPassword: false,
);

void main() {
  final uiStateObserver = MockUiStateObserver();
  final futureRunner = UnawaitedFutureRunner();
  final performSignUp = MockPerformSignUp();

  late SignUpViewModel vm;

  setUp(() {
    vm = SignUpViewModel(
      futureRunner: futureRunner,
      performSignUp: performSignUp,
    )..uiState.listen(uiStateObserver);
    disableLog();
  });
  group('sign-up', () {
    test('it should perform the sign-up', () async {
      performSignUp.setup();

      runZonedSync(() {
        vm.signUp(name: "", email: "", password: "");
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignUpState.loading),
        performSignUp(
          name: anyNamed("name"),
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
        uiStateObserver(
          SignUpStateUserSuccessfulSignedUp(user: CommonFixture.presenter.user),
        ),
      ]);
    });
    test('it shouldn\'t perform the sign-up', () async {
      performSignUp.setup(exception: appInvalidNameException);

      runZonedSync(() {
        vm.signUp(name: "", email: "", password: "");
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignUpState.loading),
        performSignUp(
          name: anyNamed("name"),
          email: anyNamed("email"),
          password: anyNamed("password"),
        ),
        uiStateObserver(emptyError.copyWith(invalidName: true)),
      ]);

      reset(uiStateObserver);
      reset(performSignUp);

      performSignUp.setup(exception: appDuplicatedUserException);

      runZonedSync(() {
        vm.signUp(name: "", email: "", password: "");
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignUpState.loading),
        uiStateObserver(emptyError.copyWith(duplicatedEmail: true)),
      ]);

      reset(uiStateObserver);
      reset(performSignUp);

      performSignUp.setup(exception: appInvalidEmailException);

      runZonedSync(() {
        vm.signUp(name: "", email: "", password: "");
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignUpState.loading),
        uiStateObserver(emptyError.copyWith(invalidEmail: true)),
      ]);

      reset(uiStateObserver);
      reset(performSignUp);

      performSignUp.setup(exception: appInvalidPasswordException);

      runZonedSync(() {
        vm.signUp(name: "", email: "", password: "");
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(SignUpState.loading),
        uiStateObserver(emptyError.copyWith(invalidPassword: true)),
      ]);
    });
  });
}

extension MockPerformSignUpExtensions on MockPerformSignUp {
  void setup({Exception? exception}) {
    when(
      this(
        name: anyNamed("name"),
        email: anyNamed("email"),
        password: anyNamed("password"),
      ),
    ).thenAnswer((realInvocation) {
      if (exception != null) {
        return Future.error(exception, StackTrace.current);
      }
      return CommonFixture.domain.user.asSynchronousFuture;
    });
  }
}
