import 'package:domain/feed.dart';

abstract class FindAllEvents {
  Future<List<Event>> call();
}
