import 'package:domain/credential.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/src/sign_in/uc/perform_sign_in.dart';

@Injectable(as: PerformSignIn)
class PerformSignInImpl implements PerformSignIn {
  final UserCmdRepository _userRepository;

  const PerformSignInImpl({required UserCmdRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User> call({required String email, required String password}) async =>
      await _userRepository.signIn(email: email, password: password);
}
