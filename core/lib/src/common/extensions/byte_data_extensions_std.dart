import 'dart:typed_data';

extension ByteDataExtensions on ByteData {
  void setUInt64Compat(int byteOffset, int value, [Endian endian = Endian.big]) {
    setUint64(byteOffset, value, endian);
  }

  int getUInt64Compat(int byteOffset, [Endian endian = Endian.big]) =>
      getUint64(byteOffset, endian);
}
