import 'dart:typed_data';

extension ByteDataExtensions on ByteData {
  void setUInt64Compat(int byteOffset, int value, [Endian endian = Endian.big]) {
    final h = value >> 32;
    final l = value & 0xffffffff;
    setUint32(byteOffset, h, endian);
    setUint32(byteOffset + 4, l, endian);
  }

  int getUInt64Compat(int byteOffset, [Endian endian = Endian.big]) =>
      (getUint32(byteOffset, endian) << 32) | getUint32(byteOffset + 4, endian);
}
