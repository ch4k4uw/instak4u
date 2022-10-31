import 'package:domain/credential.dart';

class UserView {
  final String id;
  final String name;
  final String email;

  const UserView({this.id = "", this.name = "", this.email = ""});

  static const empty = UserView();

  @override
  bool operator ==(Object other) {
    if (other is! UserView) {
      return false;
    }
    return id == other.id && name == other.name && email == other.email;
  }

  @override
  int get hashCode => Object.hash(id, name, email);

  @override
  String toString() {
    return 'UserView{id: $id, name: $name, email: $email}';
  }
}

extension UserExtension on User {
  UserView get asView =>
      UserView(
        id: id,
        name: name,
        email: email,
      );
}

extension NullableUserExtension on UserView? {
  UserView orEmpty() => this ?? const UserView();
}