import 'package:injectable/injectable.dart';

import '../../../credential/domain/entity/user.dart';
import '../../../credential/domain/repository/user_repository.dart';
import '../../domain/data/app_no_logged_user_exception.dart';
import '../../domain/repository/check_in_cmd_repository.dart';
import '../../infra/remote/check_in_api.dart';
import '../../infra/remote/model/check_in_request.dart';

@Singleton(as: CheckInCmdRepository)
class CheckInCmdRepositoryImpl implements CheckInCmdRepository {
  final CheckInApi _api;
  final UserRepository _userRepository;

  const CheckInCmdRepositoryImpl({
    required CheckInApi api,
    required UserRepository userRepository,
  })  : _api = api,
        _userRepository = userRepository;

  @override
  Future<void> performCheckIn({required String eventId}) async {
    final user = await _userRepository.findLogged();
    _assertValidUser(user: user);

    await _api.performCheckIn(
      event: CheckInRequest(
        eventId: eventId,
        name: user.name,
        email: user.email,
      ),
    );
  }

  void _assertValidUser({required User user}) {
    if (user == User.empty) {
      throw AppNoLoggedUserException();
    }
  }
}
