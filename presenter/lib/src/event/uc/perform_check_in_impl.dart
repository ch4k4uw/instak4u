import 'package:domain/check_in.dart';
import 'package:injectable/injectable.dart';

import 'perform_check_in.dart';

@Injectable(as: PerformCheckIn)
class PerformCheckInImpl implements PerformCheckIn {
  final CheckInCmdRepository _checkInRepository;

  const PerformCheckInImpl({required CheckInCmdRepository checkInRepository})
      : _checkInRepository = checkInRepository;

  @override
  Future<void> call({required String eventId}) async =>
      await _checkInRepository.performCheckIn(eventId: eventId);
}
