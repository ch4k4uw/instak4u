import 'dart:async';

import 'package:domain/src/credential/infra/service/user_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'stuff/user_storage_fixture.dart';

void main() {
  final service = UserStorage();
  UserStorage.mock = true;

  tearDown(() async {
    await UserStorage.removeLocalStorage();
  });

  test('store users', () async {
    await service.store(
      user: UserStorageFixture.user1.key,
      password: UserStorageFixture.user1.value,
    );
    await service.store(
      user: UserStorageFixture.user2.key,
      password: UserStorageFixture.user2.value,
    );
    await service.store(
      user: UserStorageFixture.user3.key,
      password: UserStorageFixture.user3.value,
    );
    expect(3, equals((await service.findUsers()).length));
    expect(UserStorageFixture.user3.key, equals(await service.restore()));
    expect(
      UserStorageFixture.user3.value,
      equals(await service.findPassword()),
    );

    await service.store(user: UserStorageFixture.user1.key);
    expect(3, equals((await service.findUsers()).length));
    expect(UserStorageFixture.user1.key, equals(await service.restore()));
    expect(UserStorageFixture.user1.key, equals(await service.restore()));
  });
}
