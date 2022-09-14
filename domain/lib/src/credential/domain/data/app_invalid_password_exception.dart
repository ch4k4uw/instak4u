import 'package:domain/src/credential/domain/data/app_credential_exception.dart';

const AppInvalidPasswordException appInvalidPasswordException =
    _AppInvalidPasswordExceptionImpl("invalid password");

abstract class AppInvalidPasswordException extends AppCredentialException {}

class _AppInvalidPasswordExceptionImpl extends AppCredentialException
    implements AppInvalidPasswordException {
  const _AppInvalidPasswordExceptionImpl([super.message]);
}
