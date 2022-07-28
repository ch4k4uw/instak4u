import 'dart:io';

abstract class AppHttpException extends IOException {
  @override
  String toString() => runtimeType.toString();
}