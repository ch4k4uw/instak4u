import 'package:core/common.dart';
import 'package:domain/credential.dart';
import 'package:domain/feed.dart';
import 'package:presenter/common.dart';
import 'package:presenter/src/common/interaction/user_view.dart';

import '../extensions/map.dart';

class CommonFixture {
  const CommonFixture._();

  static Domain domain = _domain;
  static Presenter presenter = _presenter;
}

abstract class Domain {
  User get user;

  Event get event;

  const Domain._();
}

class _Domain implements Domain {
  @override
  final Event event = Event(
    id: "a1",
    title: "a2",
    description: "a3",
    price: 10.0,
    date: DateTime.fromMillisecondsSinceEpoch(1534784400000),
    image: "a4",
    latitude: 10.1,
    longitude: 10.2,
  );

  @override
  User user = const User(
    id: "a",
    name: "b",
    email: "c",
  );
}

final Domain _domain = _Domain();

abstract class Presenter {
  UserView get user;

  EventDetailsView get event;

  Presenter._();
}

class _Presenter implements Presenter {
  final Map<String, dynamic> _lazy = {};

  @override
  EventDetailsView get event => _lazy.getOrPut(
        'a',
        () => _domain.event.asEventDetailsView,
      );

  @override
  UserView get user => _lazy.getOrPut(
        'b',
        () => _domain.user.asView,
      );
}

final Presenter _presenter = _Presenter();
