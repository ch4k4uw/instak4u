import 'package:domain/src/credential/domain/entity/user.dart';

class UserStorageFixture {
  static const user1 = MapEntry(
    User(
      id: "a1",
      name: "a2",
      email: "a3",
    ),
    "aaaa",
  );
  static const user2 = MapEntry(
    User(
      id: "b1",
      name: "b2",
      email: "b3",
    ),
    "bbbb",
  );
  static const user3 = MapEntry(
    User(
      id: "c1",
      name: "c2",
      email: "c3",
    ),
    "cccc",
  );
}
