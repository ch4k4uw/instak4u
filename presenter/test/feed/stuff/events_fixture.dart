import 'package:domain/feed.dart';
import 'package:presenter/common.dart';
import 'package:presenter/src/feed/interaction/event_head_view.dart';

class EventsFixture {
  const EventsFixture._();

  static final _eventDefaultDate =
      DateTime.fromMillisecondsSinceEpoch(1534784400000);

  static final allEvents = [
    Event(
      id: "a1",
      title: "a2",
      description: "a3",
      price: 10.0,
      date: _eventDefaultDate,
      image: "a4",
      latitude: 10.1,
      longitude: 10.2,
    ),
    Event(
      id: "b1",
      title: "b2",
      description: "b3",
      price: 20.0,
      date: _eventDefaultDate,
      image: "b4",
      latitude: 20.1,
      longitude: 20.2,
    ),
    Event(
      id: "c1",
      title: "c2",
      description: "c3",
      price: 30.0,
      date: _eventDefaultDate,
      image: "c4",
      latitude: 30.1,
      longitude: 30.2,
    ),
  ];

  static final anEvent = allEvents[0];

  static final allEventHeadViews = allEvents.asEventHeadViews;

  static final allEventDetailsView = anEvent.asEventDetailsView;
}
