import 'dart:io';
import 'dart:typed_data';

import 'package:core/common.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import './app_random_access_file.dart';

class AppRandomAccessFileImpl implements AppRandomAccessFile {
  final String _name;
  bool _isClosed = false;
  RandomAccessFile? _file;

  AppRandomAccessFileImpl({required String name}) : _name = name;

  @override
  Future<void> close() async {
    try {
      await _file?.close();
      _file = null;
      _isClosed = true;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  @override
  Future<void> delete() async {
    var file = File("${await _localPath}/$_name");
    final isFileExists = await file.exists();
    if (isFileExists) {
      await close();
      await file.delete();
    }
  }

  @override
  Future<T> lock<T>({
    required Future<T> Function(AppLockedRandomAccessFile) transaction,
  }) async {
    await _createFile();
    _file = await _file?.lock();
    try {
      final result = await transaction(
        _LockedFile(
          updateFile: (f) {
            _file = f;
          },
          findFile: () => _file!,
          getPosition: _file!.position
        ),
      );
      return result;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      rethrow;
    } finally {
      _file = await _file?.unlock();
    }
  }

  Future<void> _createFile() async {
    if (_isClosed) {
      throw const FileSystemException("file closed");
    }
    final rafFile = _file;
    if (rafFile != null) {
      return;
    }

    var file = File("${await _localPath}/$_name");
    final isFileExists = await file.exists();
    if (!isFileExists) {
      file = await file.create();
    }

    (await file.open(mode: FileMode.append)).also((it) => _file = it);
  }

  static Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  @override
  Future<Uint8List> read({
    Uint8List? buffer,
    required int bufferSize,
    int start = 0,
    int? end,
  }) async {
    await _createFile();
    buffer = buffer ?? Uint8List(bufferSize);
    await _file?.readInto(buffer, start, end);
    return buffer;
  }

  @override
  Future<void> setPosition({required int offset}) async {
    await _createFile();
    _file = await _file?.setPosition(offset);
  }

  @override
  Future<int> getPosition() async {
    await _createFile();
    return (await _file?.position()) ?? 0;
  }

  @override
  Future<bool> exists() async =>
      await File("${await _localPath}/$_name").exists();
}

class _LockedFile implements AppLockedRandomAccessFile {
  final void Function(RandomAccessFile) _updateFile;
  final RandomAccessFile Function() _findFile;
  final Future<int> Function() _getPosition;

  const _LockedFile({
    required void Function(RandomAccessFile) updateFile,
    required RandomAccessFile Function() findFile,
    required Future<int> Function() getPosition,
  })  : _updateFile = updateFile,
        _findFile = findFile,
        _getPosition = getPosition;

  @override
  Future<Uint8List> read({
    Uint8List? buffer,
    required int bufferSize,
    int start = 0,
    int? end,
  }) async {
    final file = _findFile();
    buffer = buffer ?? Uint8List(bufferSize);
    await file.readInto(buffer, start, end);
    return buffer;
  }

  @override
  Future<void> setPosition({required int offset}) async {
    final file = _findFile();
    _updateFile(await file.setPosition(offset));
  }

  @override
  Future<void> write({required Uint8List buffer}) async {
    final file = _findFile();
    _updateFile(await file.writeFrom(buffer));
  }

  @override
  Future<void> truncate({required int length}) async {
    final file = _findFile();
    _updateFile(await file.truncate(length));
  }

  @override
  Future<int> getPosition() async => await _getPosition();
}
