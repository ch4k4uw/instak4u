// Mocks generated by Mockito 5.3.2 from annotations
// in presenter/test/signup/sign_up_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:domain/credential.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:presenter/src/sign_up/interaction/sign_up_state.dart' as _i6;
import 'package:presenter/src/sign_up/uc/perform_sign_up.dart' as _i3;

import '../ui_state_observer.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUser_0 extends _i1.SmartFake implements _i2.User {
  _FakeUser_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PerformSignUp].
///
/// See the documentation for Mockito's code generation for more information.
class MockPerformSignUp extends _i1.Mock implements _i3.PerformSignUp {
  @override
  _i4.Future<_i2.User> call({
    required String? name,
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #name: name,
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i4.Future<_i2.User>.value(_FakeUser_0(
          this,
          Invocation.method(
            #call,
            [],
            {
              #name: name,
              #email: email,
              #password: password,
            },
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.User>.value(_FakeUser_0(
          this,
          Invocation.method(
            #call,
            [],
            {
              #name: name,
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i4.Future<_i2.User>);
}

/// A class which mocks [UiStateObserver].
///
/// See the documentation for Mockito's code generation for more information.
class MockUiStateObserver extends _i1.Mock
    implements _i5.UiStateObserver<_i6.SignUpState> {
  @override
  void call(_i6.SignUpState? event) => super.noSuchMethod(
        Invocation.method(
          #call,
          [event],
        ),
        returnValueForMissingStub: null,
      );
}
