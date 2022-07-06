import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppColors with Diagnosticable {
  final ColorScheme colorScheme;
  final MaterialColor primarySwatch;
  final Brightness? statusBarBrightness;
  final Color alertWarning;
  final Color alertError;
  final Color alertInfo;
  final Color alertQuestion;

  const AppColors({
    required this.colorScheme,
    required this.primarySwatch,
    this.statusBarBrightness,
    required this.alertWarning,
    required this.alertError,
    required this.alertInfo,
    required this.alertQuestion,
  });

  AppColors copyWith({
    ColorScheme? colorScheme,
    MaterialColor? primarySwatch,
    Brightness? statusBarBrightness,
    Color? alertWarning,
    Color? alertError,
    Color? alertInfo,
    Color? alertQuestion,
  }) {
    return AppColors(
      colorScheme: colorScheme ?? this.colorScheme,
      primarySwatch: primarySwatch ?? this.primarySwatch,
      statusBarBrightness: statusBarBrightness ?? this.statusBarBrightness,
      alertWarning: alertWarning ?? this.alertWarning,
      alertError: alertError ?? this.alertError,
      alertInfo: alertInfo ?? this.alertInfo,
      alertQuestion: alertQuestion ?? this.alertQuestion,
    );
  }

  AppColors lerp(AppColors other, double t) {
    return AppColors(
      colorScheme: other.colorScheme,
      primarySwatch: other.primarySwatch,
      statusBarBrightness: other.statusBarBrightness,
      alertWarning: Color.lerp(alertWarning, other.alertWarning, t)!,
      alertError: Color.lerp(alertError, other.alertError, t)!,
      alertInfo: Color.lerp(alertInfo, other.alertInfo, t)!,
      alertQuestion: Color.lerp(alertQuestion, other.alertQuestion, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<ColorScheme>('colorScheme', colorScheme,
          level: DiagnosticLevel.debug),
    );
    properties.add(
      ColorProperty('primarySwatch', primarySwatch,
          level: DiagnosticLevel.debug),
    );
    properties.add(
      StringProperty('statusBarBrightness', statusBarBrightness.toString(),
          level: DiagnosticLevel.debug),
    );
    properties.add(
      ColorProperty('alertWarning', alertWarning, level: DiagnosticLevel.debug),
    );
    properties.add(
      ColorProperty('alertError', alertError, level: DiagnosticLevel.debug),
    );
    properties.add(
      ColorProperty('alertInfo', alertInfo, level: DiagnosticLevel.debug),
    );
    properties.add(
      ColorProperty('alertQuestion', alertQuestion,
          level: DiagnosticLevel.debug),
    );
  }
}
