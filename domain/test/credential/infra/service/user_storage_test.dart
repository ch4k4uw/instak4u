import 'package:domain/credential.dart';
import 'package:domain/src/credential/infra/service/user_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'stuff/user_storage_fixture.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  test('restore removed user', () async {
    await service.store(
      user: UserStorageFixture.user1.key,
      password: UserStorageFixture.user1.value,
    );

    expect(UserStorageFixture.user1.key, equals(await service.restore()));

    await service.remove();

    expect(User.empty, equals(await service.restore()));
  });
}
