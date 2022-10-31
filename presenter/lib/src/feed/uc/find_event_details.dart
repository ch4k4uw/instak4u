import 'package:domain/feed.dart';

abstract class FindEventDetails {
  Future<Event> call({required String id});
}
