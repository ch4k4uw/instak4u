import 'package:core/common/extensions/diagnostic_properties_builder_extensions.dart';
import 'package:core/common/extensions/object_extensions.dart';
import 'package:core/ui/app_colors.dart';
import 'package:core/ui/app_dimens.dart';
import 'package:core/ui/app_typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/core.dart';

class AppThemeData extends ThemeExtension<AppThemeData> with Diagnosticable {
  late ThemeData data;
  final AppColors colors;
  final AppDimens dimens;
  final AppTypography typography;
  final SystemUiOverlayStyle? systemOverlayStyle;
  bool _isBroadcasting = false;

  AppThemeData({
    required this.colors,
    required this.dimens,
    required this.typography,
    this.systemOverlayStyle,
    BottomSheetThemeData? bottomSheetTheme,
  }) {
    data = ThemeData(
      colorScheme: colors.colorScheme,
      primarySwatch: colors.primarySwatch,
      typography: typography.material,
      appBarTheme: systemOverlayStyle.appBarTheme,
      bottomSheetTheme: bottomSheetTheme
    );
  }

  @override
  ThemeExtension<AppThemeData> lerp(
    ThemeExtension<AppThemeData>? other,
    double t,
  ) {
    if (other is! AppThemeData) {
      return this;
    }
    return AppThemeData(
      colors: colors.lerp(other.colors, t),
      dimens: dimens.lerp(other.dimens, t),
      typography: other.typography,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DiagnosticsProperty<ThemeData>('data', data,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<AppColors>('colors', colors,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<AppDimens>('dimens', dimens,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<AppTypography>('typography', typography,
          level: DiagnosticLevel.debug),
    ]);
  }

  TextTheme get textTheme => data.textTheme;

  @override
  bool operator ==(Object other) {
    if (other is! AppThemeData) {
      return false;
    }
    if(_isBroadcasting) {
      return true;
    }
    _isBroadcasting = true;

    isColorsEq() => colors == other.colors;
    isDataEq() => data == other.data;
    isDimensEq() => dimens == other.dimens;
    isTypographyEq() => typography == other.typography;
    isSysOverlayStyleEq() => systemOverlayStyle == other.systemOverlayStyle;
    try {
      return isDataEq() &&
          isDimensEq() &&
          isTypographyEq() &&
          isColorsEq() &&
          isSysOverlayStyleEq();
    } finally {
      _isBroadcasting = false;
    }
  }

  @override
  int get hashCode => hash2(
        hash4(
          data.hashCode,
          colors.hashCode,
          dimens.hashCode,
          dimens.hashCode,
        ),
        systemOverlayStyle?.hashCode ?? 0,
      );

  AppThemeData copyWith({
    AppColors? colors,
    AppDimens? dimens,
    AppTypography? typography,
    SystemUiOverlayStyle? systemOverlayStyle,
  }) {
    return AppThemeData(
      colors: colors ?? this.colors,
      dimens: dimens ?? this.dimens,
      typography: typography ?? this.typography,
      systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    );
  }
}

extension _SystemUiOverlayStyleToAppBarTheme on SystemUiOverlayStyle? {
  AppBarTheme? get appBarTheme => this?.let(_appBarTheme);
}

AppBarTheme _appBarTheme(SystemUiOverlayStyle systemOverlayStyle) =>
    AppBarTheme(systemOverlayStyle: systemOverlayStyle);
