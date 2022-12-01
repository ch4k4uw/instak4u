import 'package:core/common.dart';
import 'package:mockito/mockito.dart';

import '../../signin/sign_in_view_model_test.mocks.dart' as sign_in_vm;
import '../stuff/common_fixture.dart';

extension SignInVMMockPerformSignInExtensions on sign_in_vm.MockPerformSignIn {
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
