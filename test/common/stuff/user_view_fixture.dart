import 'package:presenter/common.dart';

class UserViewFixture {
  const UserViewFixture._();

  static const encodedUser = "o2FhYatQZWRybyBNb3R0YbpwZWRyby5tb3R0YUBhdmVudWVjb"
      "2RlLmNvbQ==";
  static const user = UserView(
    id: "aaa",
    name: "Pedro Motta",
    email: "pedro.motta@avenuecode.com",
  );
}
