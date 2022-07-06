import 'package:presenter/common.dart';

abstract class SignUpState {
  static final SignUpState loading = _ConstState();

  const SignUpState();
}

class _ConstState extends SignUpState {}

class SignUpStateUserSuccessfulSignedUp extends SignUpState {
  final UserView user;

  const SignUpStateUserSuccessfulSignedUp({required this.user});
}

class SignUpStateUserNotSignedUp extends SignUpState {
  final bool invalidName;
  final bool invalidEmail;
  final bool duplicatedEmail;
  final bool invalidPassword;

  SignUpStateUserNotSignedUp({
    required this.invalidName,
    required this.invalidEmail,
    required this.duplicatedEmail,
    required this.invalidPassword,
  });
}
