import 'package:domain/credential.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/src/common/uc/find_logged_user.dart';

@Injectable(as: FindLoggedUser)
class FindLoggedUserImpl implements FindLoggedUser {
  final UserRepository _userRepository;

  const FindLoggedUserImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User> call() async => await _userRepository.findLogged();
}
