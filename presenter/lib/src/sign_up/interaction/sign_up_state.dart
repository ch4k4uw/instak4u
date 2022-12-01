import 'package:presenter/common.dart';

abstract class SignUpState {
  static final SignUpState loading = _ConstState();

  const SignUpState();
}

class _ConstState extends SignUpState {}

class SignUpStateUserSuccessfulSignedUp extends SignUpState {
  final UserView user;

  const SignUpStateUserSuccessfulSignedUp({required this.user});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpStateUserSuccessfulSignedUp &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpStateUserNotSignedUp &&
          runtimeType == other.runtimeType &&
          invalidName == other.invalidName &&
          invalidEmail == other.invalidEmail &&
          duplicatedEmail == other.duplicatedEmail &&
          invalidPassword == other.invalidPassword;

  @override
  int get hashCode =>
      invalidName.hashCode ^
      invalidEmail.hashCode ^
      duplicatedEmail.hashCode ^
      invalidPassword.hashCode;

  SignUpStateUserNotSignedUp copyWith({
    bool? invalidName,
    bool? invalidEmail,
    bool? duplicatedEmail,
    bool? invalidPassword,
  }) {
    return SignUpStateUserNotSignedUp(
      invalidName: invalidName ?? this.invalidName,
      invalidEmail: invalidEmail ?? this.invalidEmail,
      duplicatedEmail: duplicatedEmail ?? this.duplicatedEmail,
      invalidPassword: invalidPassword ?? this.invalidPassword,
    );
  }
}
