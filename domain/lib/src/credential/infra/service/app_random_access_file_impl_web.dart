import 'dart:html';
import 'dart:math';
import 'dart:typed_data';

import 'package:domain/src/credential/infra/extensions/messagepack_extensions.dart';
import 'package:domain/src/credential/infra/service/app_random_access_file.dart';
import 'package:messagepack/messagepack.dart';

class AppRandomAccessFileImpl implements AppRandomAccessFile {
  final String _name;
  int _position = 0;
  bool _isClosed = false;
  bool _isLocked = false;

  AppRandomAccessFileImpl({required String name}) : _name = name;

  @override
  Future<void> close() async {
    _isLocked = false;
    _isClosed = true;
  }

  @override
  Future<void> delete() async {
    _assertUnlockState();
    _assertOpenState();
    window.localStorage.remove(_name);
  }

  void _assertUnlockState() {
    if (_isLocked) {
      throw Exception("file locked");
    }
  }

  void _assertOpenState() {
    if (_isClosed) {
      throw Exception("file closed");
    }
  }

  @override
  Future<T> lock<T>({
    required Future<T> Function(AppLockedRandomAccessFile) transaction,
  }) async {
    _assertUnlockState();
    _assertOpenState();
    _isLocked = true;
    try {
      return await transaction(
        _LockedFile(
          name: _name,
          file: this,
          setPosition: _setPosition,
          getPosition: _getPosition,
        ),
      );
    } finally {
      _isLocked = false;
    }
  }

  @override
  Future<Uint8List> read({
    Uint8List? buffer,
    required int bufferSize,
    int start = 0,
    int? end,
  }) async {
    _assertOpenState();
    assert(start >= 0);
    assert(end == null || end >= start);
    assert(end == null || start < end);
    assert(bufferSize <= (end ?? bufferSize));

    end = end ?? bufferSize;
    final size = end - start;

    buffer = buffer ?? Uint8List(bufferSize);
    final rawData = window.localStorage[_name];

    if (rawData == null || size == 0) {
      return buffer;
    }

    final unPacker = rawData.unmarshall();
    final rawBytes = unPacker.unpackBinary();
    final bytes = ByteData.view(
      Uint8List.fromList(
        rawBytes.getRange(_position, _position + size).toList(),
      ).buffer,
    );

    buffer.setRange(
      start,
      end,
      Uint8List.sublistView(bytes.buffer.asByteData()),
    );

    return buffer;
  }

  @override
  Future<void> setPosition({required int offset}) async {
    _assertUnlockState();
    await _setPosition(offset: offset);
  }

  Future<void> _setPosition({required int offset}) async {
    _assertOpenState();
    assert(offset >= 0);
    final rawData = window.localStorage[_name];
    if (rawData != null) {
      final unPacker = rawData.unmarshall();
      final rawBytes = unPacker.unpackBinary();
      assert(offset <= rawBytes.length);
    } else {
      assert(offset == 0);
    }
    _position = offset;
  }

  @override
  Future<int> getPosition() async {
    _assertUnlockState();
    return await _getPosition();
  }

  Future<int> _getPosition() async {
    _assertOpenState();
    return _position;
  }

  @override
  Future<bool> exists() async => window.localStorage[_name] != null;
}

class _LockedFile implements AppLockedRandomAccessFile {
  final String _name;
  final AppRandomAccessFileImpl _file;
  final Future<void> Function({required int offset}) _setPosition;
  final Future<int> Function() _getPosition;

  _LockedFile({
    required String name,
    required AppRandomAccessFileImpl file,
    required Future<void> Function({required int offset}) setPosition,
    required Future<int> Function() getPosition,
  })  : _name = name,
        _file = file,
        _setPosition = setPosition,
        _getPosition = getPosition;

  @override
  Future<Uint8List> read({
    Uint8List? buffer,
    required int bufferSize,
    int start = 0,
    int? end,
  }) async {
    return await _file.read(
        buffer: buffer, bufferSize: bufferSize, start: start, end: end);
  }

  @override
  Future<void> setPosition({required int offset}) async {
    await _setPosition(offset: offset);
  }

  @override
  Future<int> getPosition() async => await _getPosition();

  @override
  Future<void> truncate({required int length}) async {
    final rawData = window.localStorage[_name];
    if (rawData == null) {
      return;
    }
    final unPacker = rawData.unmarshall();
    final rawBytes = unPacker.unpackBinary();
    length = min(length, rawBytes.length);
    final viewBytes = rawBytes.getRange(0, length).toList(growable: false);
    final packer = Packer();
    packer.packBinary(viewBytes);
    window.localStorage[_name] = packer.marshall();
  }

  @override
  Future<void> write({required Uint8List buffer}) async {
    final rawData = window.localStorage[_name];
    final rawBytes = rawData?.unmarshall().unpackBinary() ?? List.empty();
    final bytesBuilder = BytesBuilder();
    var position = await getPosition();

    if (rawBytes.isNotEmpty) {
      bytesBuilder.add(rawBytes.getRange(0, position).toList());
    }

    bytesBuilder.add(buffer);
    position += buffer.length;

    if (position < rawBytes.length) {
      bytesBuilder.add(rawBytes.getRange(position, rawBytes.length).toList());
    }

    final packer = Packer(bytesBuilder.length);
    packer.packBinary(bytesBuilder.takeBytes());

    window.localStorage[_name] = packer.marshall();
    await setPosition(offset: position);
  }
}
