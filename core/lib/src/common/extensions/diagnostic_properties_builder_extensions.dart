import 'package:flutter/foundation.dart';

extension DiagnosticPropertiesBuilderAddAll on DiagnosticPropertiesBuilder {
  void addAll(List<DiagnosticsNode> properties) {
    for (var element in properties) {
      add(element);
    }
  }
}
