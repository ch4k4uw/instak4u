import 'package:domain/src/credential/infra/service/password_hashing.dart';
import 'package:flutter_test/flutter_test.dart';

import 'stuff/password_hashing_fixture.dart';

void main() {
  final service = PasswordHashing();

  test('compare with different hash setup', () async {
    final currHash = await service.hash(
      password: PasswordHashingFixture.hashedPassword3[0],
    );
    expect(
      currHash,
      isNot(equals(PasswordHashingFixture.hashedPassword3[1])),
    );
  });

  test("hash password", () async {
    final hash1 =
        await service.hash(password: PasswordHashingFixture.password1);
    final hash2 =
        await service.hash(password: PasswordHashingFixture.password2);
    final hash3 =
        await service.hash(password: PasswordHashingFixture.password3);

    expect(hash1, isNot(equals(PasswordHashingFixture.password1)));
    expect(hash2, isNot(equals(PasswordHashingFixture.password2)));
    expect(hash3, isNot(equals(PasswordHashingFixture.password3)));

    expect(hash1, isNot(equals(hash2)));
    expect(hash1, isNot(equals(hash3)));
    expect(hash2, isNot(equals(hash3)));

    expect(
      await service.compare(PasswordHashingFixture.password1, hash1),
      isTrue,
    );
    expect(
      await service.compare(PasswordHashingFixture.password2, hash2),
      isTrue,
    );
    expect(
      await service.compare(PasswordHashingFixture.password3, hash3),
      isTrue,
    );
  });
}
