import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:core/common.dart';
import 'package:domain/src/credential/domain/entity/user.dart';
import 'package:injectable/injectable.dart';
import 'package:messagepack/messagepack.dart';
import 'package:path_provider/path_provider.dart';

const _storageName = "domain_settings";

@singleton
class UserStorage {
  static final storageMutex = Mutex();
  static bool mock = false;

  Future<void> store({
    required User user,
    String? password,
  }) async {
    await storageMutex.sync(() async {
      var userLocal = _UserLocal(
        id: user.id,
        name: user.name,
        email: user.email,
        password: password ?? "",
      );

      final usersLocal = (await _decodeUsersLocal()).let((usersLocal) {
        if (usersLocal == _UsersLocal.empty) {
          return _UsersLocal(users: [userLocal]);
        }
        final existing = usersLocal.users.indexWhere(
          (it) => it.id == user.id,
        );
        return usersLocal.copyWith(
          users: List<_UserLocal>.from(
            usersLocal.users,
            growable: existing == -1,
          ).also((it) {
            if (existing != -1) {
              if (password == null) {
                it[existing] = it[existing].copyWith(
                  password: it[existing].password,
                );
              } else {
                it[existing] = userLocal;
              }
              userLocal = it[existing];
            } else {
              it.add(userLocal);
            }
          }),
        );
      });

      await _LocalStorageLocal(
        user: userLocal,
        users: usersLocal,
        mock: mock,
      ).save();
    });
  }

  Future<_UsersLocal> _decodeUsersLocal() async {
    return await _LocalStorageLocal.decodeUsersLocal(mock: mock);
  }

  Future<void> remove() async {
    return await storageMutex.sync(() async {
      await _LocalStorageLocal.removeUser(mock: mock);
    });
  }

  Future<User> restore() async {
    return await storageMutex.sync(() async {
      return (await _LocalStorageLocal.decodeUserLocal(mock: mock)).toDomain();
    });
  }

  Future<String> findPassword() async {
    return await storageMutex.sync(() async {
      return (await _LocalStorageLocal.decodeUserLocal(mock: mock)).password;
    });
  }

  Future<List<User>> findUsers() async {
    return await storageMutex.sync(() async {
      return (await _LocalStorageLocal.decodeUsersLocal(mock: mock))
          .users
          .map((e) => e.toDomain())
          .toList(growable: false);
    });
  }

  Future<User> findUserByEmail({required String email}) async {
    return await storageMutex.sync(() async {
      return (await _LocalStorageLocal.decodeUsersLocal(mock: mock))
          .users
          .firstWhere(
            (element) => element.email == email,
            orElse: () => _UserLocal.empty,
          )
          .toDomain();
    });
  }

  Future<String> findPasswordByEmail({required String email}) async {
    return await storageMutex.sync(() async {
      return (await _LocalStorageLocal.decodeUsersLocal(mock: mock))
          .users
          .firstWhere(
            (element) => element.email == email,
            orElse: () => _UserLocal.empty,
          )
          .password;
    });
  }

  static Future<void> removeLocalStorage() async {
    await storageMutex.sync(
      () async => _LocalStorageLocal.removeData(
        mock: mock,
      ),
    );
  }
}

typedef _TaskItem = MapEntry<Completer<dynamic>, Future<dynamic> Function()>;

class Mutex {
  final _taskQueue = <_TaskItem>[];
  var _isBroadcasting = false;

  Future<T> sync<T>(Future<dynamic> Function() task) async {
    final result = Completer<T>();
    final taskItem = _TaskItem(result, task);
    _taskQueue.add(taskItem);
    if (!_isBroadcasting) {
      _isBroadcasting = true;
      _execNext();
    }
    return result.future;
  }

  Future<void> _execNext() async {
    final taskItem = _taskQueue[0];
    try {
      final result = await taskItem.value();
      taskItem.key.complete(result);
    } catch (e) {
      taskItem.key.completeError(e);
    } finally {
      if (_taskQueue.length == 1) {
        _isBroadcasting = false;
      }
      _taskQueue.removeAt(0);
      if (_taskQueue.isNotEmpty) {
        _execNext();
      }
    }
  }
}

class _LocalStorageLocal {
  _UserLocal user;
  _UsersLocal users;
  final bool _mock;

  _LocalStorageLocal({
    required this.user,
    required this.users,
    required bool mock,
  }) : _mock = mock;

  Future<void> save() async {
    await _writeFileData(user: user, users: users, mock: _mock);
  }

  static Future<_UserLocal> decodeUserLocal({bool mock = false}) async {
    return await _readFileData(
      key: "user",
      defaultValue: _UserLocal.empty,
      mock: mock,
      creator: (unPacker) => _UserLocal.create(unPacker: unPacker),
    );
  }

  static Future<T> _readFileData<T>({
    required String key,
    required T defaultValue,
    bool mock = false,
    required T Function(Unpacker) creator,
  }) async {
    final isUserRequired = key == "user";

    var file = await _createFile(mock: mock);
    try {
      final fileMetadata = await _fileTransaction<T>(
        file: file,
        transaction: (f) async {
          final fileMetadata = await _readFileHeader(file: file);
          final uDiskSize = fileMetadata.value.key.key;
          final uSize = fileMetadata.value.key.value;
          final usSize = fileMetadata.value.value;

          if ((isUserRequired && uSize == 0) ||
              (!isUserRequired && usSize == 0)) {
            return MapEntry(fileMetadata.key, defaultValue);
          }

          final offset = 16 + (isUserRequired ? 0 : uDiskSize);
          final size = isUserRequired ? uSize : usSize;

          final rawBuffer = Uint8List(size);

          file = await file.setPosition(offset);
          await file.readInto(rawBuffer);

          final unPacker = Unpacker(rawBuffer);

          return MapEntry(fileMetadata.key, creator(unPacker));
        },
      );
      file = fileMetadata.key;
      return fileMetadata.value;
    } finally {
      await file.close();
    }
  }

  static Future<void> removeUser({bool mock = false}) async {
    var file = await _createFile(mock: mock);
    final rawUserHeader = Uint8List(16);

    try {
      final fileMetadata = await _fileTransaction(
        file: file,
        transaction: (f) async {
          file = await f.setPosition(0);
          await file.readInto(rawUserHeader);

          final userHeader = ByteData.view(rawUserHeader.buffer);
          userHeader.setInt32(4, 0);

          await file.writeFrom(Uint8List.view(userHeader.buffer));

          return MapEntry(file, null);
        },
      );
      file = fileMetadata.key;
    } finally {
      await file.close();
    }
  }

  static Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<RandomAccessFile> _createFile({bool mock = false}) async {
    /**
     * File header:
     *  [32bits: User disk size, 32bits: User size]
     *  [64Bits: Users size]
     *
     * File data:
     *  [User data]
     *  [Users data]
     */
    final path = await _localPath;
    var file = File("$path/$_storageName${mock ? ".mock" : ""}");
    final isFileExists = await file.exists();
    if (!isFileExists) {
      file.create();
    }
    return await (await file.open(mode: FileMode.append)).let((it) async {
      var result = it;
      if (!isFileExists) {
        final resultMetadata = await _fileTransaction(
          file: result,
          transaction: (f) async {
            return MapEntry(await _writeFileHeader(file: f), null);
          },
        );
        result = resultMetadata.key;
      }
      return result;
    });
  }

  static Future<MapEntry<RandomAccessFile, T>> _fileTransaction<T>({
    required RandomAccessFile file,
    required Future<MapEntry<RandomAccessFile, T>> Function(RandomAccessFile)
        transaction,
  }) async {
    var result = await file.lock();
    try {
      return await transaction(result);
    } finally {
      result = await result.unlock();
    }
  }

  static Future<RandomAccessFile> _writeFileHeader({
    required RandomAccessFile file,
    int uDiskSize = 0,
    int uSize = 0,
    int usSize = 0,
  }) async {
    final rawBuffer = Uint8List(16);
    final buffer = ByteData.view(rawBuffer.buffer);
    buffer.setUint32(0, uDiskSize);
    buffer.setUint32(4, uSize);
    buffer.setUint64(8, usSize);

    final result = await file.setPosition(0);
    await result.writeFrom(Uint8List.view(buffer.buffer));

    return result;
  }

  static Future<_FileHeaderResult> _readFileHeader({
    required RandomAccessFile file,
  }) async {
    var fileResult = await file.setPosition(0);
    var uDiskSizeResult = 0;
    var uSizeResult = 0;
    var usSizeResult = 0;

    final rawBuffer = Uint8List(16);

    await fileResult.readInto(rawBuffer);

    final buffer = ByteData.view(rawBuffer.buffer);

    uDiskSizeResult = buffer.getInt32(0);
    uSizeResult = buffer.getInt32(4);
    usSizeResult = buffer.getInt64(8);

    final uHeader = MapEntry(uDiskSizeResult, uSizeResult);
    return _FileHeaderResult(fileResult, MapEntry(uHeader, usSizeResult));
  }

  static Future<_UsersLocal> decodeUsersLocal({bool mock = false}) async {
    return await _readFileData(
      key: "users",
      defaultValue: _UsersLocal.empty,
      mock: mock,
      creator: (unPacker) => _UsersLocal.create(unPacker: unPacker),
    );
  }

  static Future<void> _writeFileData({
    _UserLocal user = _UserLocal.empty,
    _UsersLocal? users,
    bool mock = false,
  }) async {
    final hasUser = user != _UserLocal.empty;
    final hasUsers = users != null;
    if (!hasUser && !hasUsers) {
      return;
    }
    final userPacker = Packer();
    final usersPacker = Packer();
    if (hasUser) {
      user.writeToPacker(packer: userPacker);
    }
    if (hasUsers) {
      users.writeToPacker(packer: usersPacker);
    }
    final rawUserBuffer = hasUser ? userPacker.takeBytes() : Uint8List(0);
    final rawUsersBuffer = hasUsers ? usersPacker.takeBytes() : Uint8List(0);

    var file = await _createFile(mock: mock);
    try {
      final transactionResult = await _fileTransaction(
        file: file,
        transaction: (f) async {
          final fileMetadata = await _readFileHeader(file: f);
          final uDiskSize = max(
            rawUserBuffer.length,
            fileMetadata.value.key.key,
          );

          var file = fileMetadata.key;

          file = await _writeFileHeader(
            file: file,
            uDiskSize: uDiskSize,
            uSize: rawUserBuffer.length,
            usSize: rawUsersBuffer.length,
          );
          file = await file.writeFrom(rawUserBuffer);
          file = await file.setPosition(16 + uDiskSize);
          file = await file.writeFrom(rawUsersBuffer);
          file = await file.truncate(16 + uDiskSize + rawUsersBuffer.length);
          return MapEntry(file, null);
        },
      );
      file = transactionResult.key;
    } finally {
      await file.close();
    }
  }

  static Future<void> removeData({bool mock = false}) async {
    final path = await _localPath;
    var file = File("$path/$_storageName${mock ? ".mock" : ""}");
    final isFileExists = await file.exists();
    if (isFileExists) {
      await file.delete();
    }
  }
}

typedef _FileHeaderResult
    = MapEntry<RandomAccessFile, MapEntry<MapEntry<int, int>, int>>;

class _UsersLocal {
  List<_UserLocal> users;

  static _UsersLocal empty = _UsersLocal(users: List.empty());

  _UsersLocal({required List<_UserLocal> users})
      : users = List.unmodifiable(users);

  void writeToPacker({required Packer packer}) {
    packer.packListLength(users.length);
    for (var user in users) {
      var innPacker = Packer();
      user.writeToPacker(packer: innPacker);
      packer.packBinary(innPacker.takeBytes());
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _UsersLocal &&
          runtimeType == other.runtimeType &&
          users.length == other.users.length &&
          users == other.users;

  @override
  int get hashCode => users.hashCode;

  @override
  String toString() {
    return '_UsersLocal{users: $users}';
  }

  _UsersLocal copyWith({List<_UserLocal>? users}) {
    return _UsersLocal(users: users ?? []);
  }

  static _UsersLocal create({required Unpacker unPacker}) {
    var size = unPacker.unpackListLength();
    var users = List<_UserLocal>.empty(growable: true);
    for (var i = 0; i < size; ++i) {
      var innUnPacker = Unpacker(Uint8List.fromList(unPacker.unpackBinary()));
      users.add(_UserLocal.create(unPacker: innUnPacker));
    }
    return _UsersLocal(users: users);
  }
}

class _UserLocal {
  static const empty = _UserLocal();

  final String id;
  final String name;
  final String email;
  final String password;

  const _UserLocal({
    this.id = "",
    this.name = "",
    this.email = "",
    this.password = "",
  });

  void writeToPacker({required Packer packer}) {
    packer.packString(id);
    packer.packString(name);
    packer.packString(email);
    packer.packString(password);
  }

  @override
  bool operator ==(Object other) {
    if (other is! _UserLocal) {
      return false;
    }
    return id == other.id &&
        name == other.name &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode => Object.hash(id, name, email, password);

  @override
  String toString() {
    return '_UserLocal{'
        ' id: $id, '
        ' name: $name, '
        ' email: $email, '
        ' password: $password'
        '}';
  }

  _UserLocal copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    return _UserLocal(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  static _UserLocal create({required Unpacker unPacker}) {
    final id = unPacker.unpackString();
    final name = unPacker.unpackString();
    final email = unPacker.unpackString();
    final password = unPacker.unpackString();
    if (id == null || name == null || email == null || password == null) {
      return empty;
    }
    return _UserLocal(
      id: id,
      name: name,
      email: email,
      password: password,
    );
  }
}

extension _UserLocalExtension on _UserLocal {
  User toDomain() {
    if (this == _UserLocal.empty) {
      return User.empty;
    }
    return User(id: id, name: name, email: email);
  }
}
