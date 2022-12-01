import 'package:presenter/common.dart';

abstract class SignInState {
  static final SignInState loading = _ConstState();
  static final SignInState loaded = _ConstState();
  static final SignInState userNotSignedIn = _ConstState();

  const SignInState();
}

class _ConstState extends SignInState {}

class SignInStateUserAlreadyLoggedIn extends SignInState {
  final UserView user;

  const SignInStateUserAlreadyLoggedIn({required this.user});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInStateUserAlreadyLoggedIn &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class SignInStateUserSuccessfulSignedIn extends SignInState {
  final UserView user;

  const SignInStateUserSuccessfulSignedIn({required this.user});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInStateUserSuccessfulSignedIn &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}
