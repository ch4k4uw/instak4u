import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../stuff/user_view_fixture.dart';
import 'package:presenter/common.dart';


void main() {
  test('encode user', () {
    const user = UserViewFixture.user;
    final encoded = user.marshall();
    final decoded = encoded.unmarshallToUserView();
    expect(decoded, equals(user));
  });
}