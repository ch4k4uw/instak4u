import 'dart:typed_data';
import 'package:core/common.dart';

import './app_random_access_file_impl_io.dart'
    if (dart.library.html) './app_random_access_file_impl_web.dart';

abstract class AppRandomAccessFile {
  factory AppRandomAccessFile.create({required String name}) =
      AppRandomAccessFileImpl;

  Future<bool> exists();

  Future<T> lock<T>({
    required Future<T> Function(AppLockedRandomAccessFile) transaction,
  });

  Future<void> setPosition({required int offset});

  Future<int> getPosition();

  Future<Uint8List> read({
    Uint8List? buffer,
    required int bufferSize,
    int start = 0,
    int? end,
  });

  Future<void> delete();

  Future<void> close();
}

abstract class AppLockedRandomAccessFile {
  Future<void> setPosition({required int offset});

  Future<int> getPosition();

  Future<void> write({required Uint8List buffer});

  Future<void> truncate({required int length});

  Future<Uint8List> read({
    Uint8List? buffer,
    required int bufferSize,
    int start = 0,
    int? end,
  });
}

extension AppLockedRandomAccessFileExtensions on AppLockedRandomAccessFile {
  Future<void> writeByteData({required ByteData byteData}) async {
    await write(buffer: Uint8List.view(byteData.buffer));
  }

  Future<ByteData> readByteData({
    Uint8List? buffer,
    required int bufferSize,
    int start = 0,
    int? end,
  }) async {
    return (await read(
      buffer: buffer,
      bufferSize: bufferSize,
      start: start,
      end: end,
    )).let(
            (it) => ByteData.view(it.buffer)
    );
  }
}
