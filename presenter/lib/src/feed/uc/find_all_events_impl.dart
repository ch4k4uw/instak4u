import 'package:domain/feed.dart';
import 'package:injectable/injectable.dart';

import 'find_all_events.dart';

@Injectable(as: FindAllEvents)
class FindAllEventsImpl implements FindAllEvents {
  final EventRepository _repository;

  const FindAllEventsImpl({required EventRepository repository})
      : _repository = repository;

  @override
  Future<List<Event>> call() async => await _repository.findAll();
}
