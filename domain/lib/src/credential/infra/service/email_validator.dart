import 'package:injectable/injectable.dart';

final emailExp = RegExp(
  "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}"
  "\\@"
  "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
  "("
  "\\."
  "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
  ")+",
);

@singleton
class EmailValidator {
  bool isValid({required String email}) => emailExp.hasMatch(email);
}
