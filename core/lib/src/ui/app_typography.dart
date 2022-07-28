import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTypography with Diagnosticable {
  final Typography material;

  const AppTypography({required this.material});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<Typography>('material', material,
          level: DiagnosticLevel.debug),
    );
  }
}
