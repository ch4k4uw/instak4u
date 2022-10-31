import 'package:domain/feed.dart';

class EventHeadView {
  final String id;
  final String title;
  final DateTime date;
  final double price;
  final String image;
  final double lat;
  final double long;

  EventHeadView({
    required this.id,
    required this.title,
    required this.date,
    required this.price,
    required this.image,
    required this.lat,
    required this.long,
  });
}

extension EventsExtensions on List<Event> {
  List<EventHeadView> get asEventHeadViews =>
      map((e) => e.asEventHeadView).toList();
}

extension EventExtensions on Event {
  EventHeadView get asEventHeadView => EventHeadView(
        id: id,
        title: title,
        date: date,
        price: price,
        image: image,
        lat: latitude,
        long: longitude,
      );
}
