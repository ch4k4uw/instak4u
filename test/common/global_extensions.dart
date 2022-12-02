import 'package:flutter/foundation.dart';

void disableLog() {
  debugPrint = (String? message, {int? wrapWidth}) {};
}