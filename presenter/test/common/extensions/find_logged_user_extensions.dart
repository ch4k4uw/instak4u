import 'package:core/common.dart';
import 'package:domain/credential.dart';
import 'package:mockito/mockito.dart';
import 'package:presenter/src/common/uc/find_logged_user.dart';

import '../stuff/common_fixture.dart';

extension FindLoggedUserExtensions on FindLoggedUser {
  void setup({bool hasLoggedUser = false}) {
    when(this()).thenAnswer((realInvocation) {
      if (hasLoggedUser) {
        return CommonFixture.domain.user.asSynchronousFuture;
      }
      return User.empty.asSynchronousFuture;
    });
  }
}
