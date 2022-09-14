import 'package:domain/credential.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/src/sign_up/uc/perform_sign_up.dart';

@Injectable(as: PerformSignUp)
class PerformSignUpImpl implements PerformSignUp {
  final UserCmdRepository _userRepository;

  const PerformSignUpImpl({required UserCmdRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User> call({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = User(name: name, email: email);
    return await _userRepository.signUp(user, password);
  }
}
