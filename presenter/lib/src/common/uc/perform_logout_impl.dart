import 'package:domain/credential.dart';
import 'package:injectable/injectable.dart';

import 'perform_logout.dart';

@Injectable(as: PerformLogout)
class PerformLogoutImpl implements PerformLogout {
  final UserCmdRepository _repository;

  const PerformLogoutImpl({required UserCmdRepository repository}) :
      _repository = repository;

  @override
  Future<void> call() async => await _repository.logout();
}