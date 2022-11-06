import 'dart:ui';

import 'package:flutter/foundation.dart';

class AppDoubles with Diagnosticable {
  final double defaultOpacity;

  const AppDoubles({this.defaultOpacity = .12});

  AppDoubles copyWith({
    double? defaultOpacity,
  }) {
    return AppDoubles(
      defaultOpacity: defaultOpacity ?? this.defaultOpacity,
    );
  }

  AppDoubles lerp(AppDoubles others, double t) {
    return AppDoubles(
      defaultOpacity: lerpDouble(defaultOpacity, others.defaultOpacity, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<double>('defaultOpacity', defaultOpacity,
          level: DiagnosticLevel.debug),
    );
  }
}
