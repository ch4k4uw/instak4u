import 'package:core/common.dart';
import 'package:domain/src/credential/infra/extensions/messagepack_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:messagepack/messagepack.dart';
import 'package:cryptography/cryptography.dart';
import 'package:uuid/uuid.dart';

class PasswordHashing {
  static const _interactionCount = 0xff;

  Future<String> hash({required String password}) async {
    final salt = const Uuid().v4();
    const count = _interactionCount;
    final hashedPassword = await _hash(
      salt: salt,
      password: password,
      interactions: count,
    );
    final packer = Packer();
    _PasswordLocal(
      salt: salt,
      interactions: count,
      password: hashedPassword,
    ).writeToPacker(packer: packer);
    return packer.marshall();
  }

  Future<String> _hash({
    required String salt,
    required String password,
    required int interactions,
  }) async {
    var hashedPassword = salt = password;
    final alg = Sha512();
    for (var i = 0; i < interactions; ++i) {
      hashedPassword = _toHex(
        bytes: (await alg.hash(hashedPassword.codeUnits)).bytes,
      );
    }
    return hashedPassword;
  }

  String _toHex({required List<int> bytes}) {
    return bytes
        .map((e) => (0xff & e).toRadixString(16))
        .map((e) => e.length < 2 ? "0$e" : e)
        .fold("", (previousValue, element) => previousValue + element);
  }

  Future<bool> compare(String password, String hash) async {
    final unPacker = hash.unmarshall();
    return await _PasswordLocal.create(unPacker: unPacker)
        .let((passwordLocal) async {
      if (passwordLocal != _PasswordLocal.empty) {
        final hashedPassword = await _hash(
          salt: passwordLocal.salt,
          password: password,
          interactions: passwordLocal.interactions,
        );
        debugPrint("Comparing: \"$hashedPassword\" with "
            "\"${passwordLocal.password}\"");
        return hashedPassword == passwordLocal.password;
      }
      debugPrint("Password is empty");
      return false;
    });
  }
}

class _PasswordLocal {
  static const empty = _PasswordLocal();

  final String salt;
  final int interactions;
  final String password;

  const _PasswordLocal({
    this.salt = "",
    this.interactions = 0,
    this.password = "",
  });

  void writeToPacker({required Packer packer}) {
    packer.packString(salt);
    packer.packInt(interactions);
    packer.packString(password);
  }

  static _PasswordLocal create({required Unpacker unPacker}) {
    final salt = unPacker.unpackString();
    final interactions = unPacker.unpackInt();
    final password = unPacker.unpackString();
    if (salt == null || interactions == null || password == null) {
      return empty;
    }
    return _PasswordLocal(
      salt: salt,
      interactions: interactions,
      password: password,
    );
  }
}
