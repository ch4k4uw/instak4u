import 'dart:convert';
import 'dart:typed_data';

import 'package:messagepack/messagepack.dart';

extension PackerExtensions on Packer {
  String marshall() {
    final bytes = takeBytes();
    return Uri.encodeFull(base64Encode(bytes));
  }
}

extension StringExtensions on String {
  Unpacker unmarshall() {
    if (isEmpty) {
      return Unpacker(Uint8List(0));
    }
    final rawData = base64Decode(Uri.decodeFull(this));
    return Unpacker(rawData);
  }
}