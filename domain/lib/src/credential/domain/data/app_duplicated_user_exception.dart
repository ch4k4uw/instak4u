import 'package:domain/src/credential/domain/data/app_credential_exception.dart';

const AppDuplicatedUserException appDuplicatedUserException =
    _AppDuplicatedUserException("duplicated user");

abstract class AppDuplicatedUserException extends AppCredentialException {}

class _AppDuplicatedUserException extends AppCredentialException
    implements AppDuplicatedUserException {
  const _AppDuplicatedUserException([super.message]);
}
