import 'package:domain/src/credential/domain/data/app_credential_exception.dart';

const AppInvalidEmailException appInvalidEmailException =
    _AppInvalidEmailExceptionImpl("invalid email");

abstract class AppInvalidEmailException extends AppCredentialException {}

class _AppInvalidEmailExceptionImpl extends AppCredentialException
    implements AppInvalidEmailException {
  const _AppInvalidEmailExceptionImpl([super.message]);
}
