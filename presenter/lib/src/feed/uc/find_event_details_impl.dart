import 'package:domain/feed.dart';
import 'package:injectable/injectable.dart';

import 'find_event_details.dart';

@Injectable(as: FindEventDetails)
class FindEventDetailsImpl implements FindEventDetails {
  final EventRepository _repository;

  const FindEventDetailsImpl({required EventRepository repository})
      : _repository = repository;

  @override
  Future<Event> call({required String id}) async =>
      await _repository.find(id: id);
}
