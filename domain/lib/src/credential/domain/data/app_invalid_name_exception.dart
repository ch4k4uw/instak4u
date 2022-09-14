import 'package:domain/src/credential/domain/data/app_credential_exception.dart';

const AppInvalidNameException appInvalidNameException =
    _AppInvalidNameExceptionImpl("invalid name");

abstract class AppInvalidNameException extends AppCredentialException {}

class _AppInvalidNameExceptionImpl extends AppCredentialException
    implements AppInvalidNameException {
  const _AppInvalidNameExceptionImpl([super.message]);
}
