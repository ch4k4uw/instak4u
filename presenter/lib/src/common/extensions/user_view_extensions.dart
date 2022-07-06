import 'dart:convert';

import 'package:messagepack/messagepack.dart';

import '../interaction/user_view.dart';

extension UserViewMarshalling on UserView {
  String marshall() {
    final packer = Packer();
    packer.packString(id);
    packer.packString(name);
    packer.packString(email);
    final bytes = packer.takeBytes();
    return Uri.encodeFull(base64Encode(bytes));
  }
}

extension StringToUserView on String {
  UserView unmarshallToUserView() {
    final bytes = base64Decode(Uri.decodeFull(this));
    final unPacker = Unpacker.fromList(bytes);
    final id = unPacker.unpackString();
    final name = unPacker.unpackString();
    final email = unPacker.unpackString();
    var isNull = id == null;
    isNull = isNull || name == null;
    isNull = isNull || email == null;
    if (isNull) {
      return UserView.empty;
    }
    return UserView(id: id, name: name, email: email);
  }
}