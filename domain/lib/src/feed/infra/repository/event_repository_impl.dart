import 'package:domain/src/feed/domain/entity/event.dart';
import 'package:domain/src/feed/infra/remote/event_api.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/event_repository.dart';

@Singleton(as: EventRepository)
class EventRepositoryImpl implements EventRepository {
  final EventApi _api;

  const EventRepositoryImpl({required EventApi api}) : _api = api;

  @override
  Future<Event> find({required String id}) async => await _api.find(id: id);

  @override
  Future<List<Event>> findAll() async => await _api.findAll();
}
