import 'package:domain/src/feed/domain/entity/event.dart';

abstract class EventRepository {
  Future<List<Event>> findAll();

  Future<Event> find({required String id});
}
