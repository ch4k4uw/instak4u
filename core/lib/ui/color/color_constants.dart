import 'package:core/common/lazy.dart';
import 'package:core/ui/app_colors.dart';
import 'package:flutter/material.dart';

final lightColors = Lazy(
  creator: () => AppColors(
    colorScheme: _lightColors.value,
    primarySwatch: _lightPrimarySwatch.value,
    statusBarBrightness: Brightness.light,
    alertWarning: _Light.amber600,
    alertError: _Light.deepOrange600,
    alertInfo: _Light.green600,
    alertQuestion: _Light.amber600,
  ),
);

final _lightColors = Lazy(
  creator: () => const ColorScheme(
    primary: _Light.lightGreen600,
    primaryContainer: _Light.lightGreen800,
    secondary: _Light.amber600,
    secondaryContainer: _Light.amber800,
    background: _white,
    surface: _Light.gray50,
    error: _Light.red900,
    onPrimary: _white,
    onSecondary: _white,
    onBackground: _black,
    onSurface: _black,
    onError: _white,
    brightness: Brightness.light,
  ),
);

const _black = Color(0xFF000000);
const _white = Color(0xFFFFFFFF);

class _Light {
  _Light._();

  static const amber600 = Color(0xFFFFB300);
  static const amber800 = Color(0xFFFF8F00);
  static const lightGreen600 = Color(0xFF7CB342);
  static const lightGreen800 = Color(0xFF558B2F);
  static const red900 = Color(0xFFB71C1C);
  static const gray50 = Color(0xFFFAFAFA);
  static const deepOrange600 = Color(0xFFF4511E);
  static const green600 = Color(0xFF43A047);
}

final _lightPrimarySwatch = Lazy(creator: () => Colors.lightGreen);

final darkColors = Lazy(
  creator: () => AppColors(
    colorScheme: _darkColors.value,
    primarySwatch: _darkPrimarySwatch.value,
    statusBarBrightness: Brightness.dark,
    alertWarning: Colors.amber,
    alertError: _Dark.deepOrange300,
    alertInfo: _Dark.green300,
    alertQuestion: _Dark.amber200,
  ),
);

final _darkColors = Lazy(
  creator: () => const ColorScheme(
    primary: _Dark.lightGreen300,
    primaryContainer: _Dark.lightGreen900,
    secondary: _Dark.amber300,
    secondaryContainer: _Dark.amber800,
    background: _Dark.background,
    surface: _Dark.gray900,
    error: _Dark.red300,
    onPrimary: _black,
    onSecondary: _black,
    onBackground: _white,
    onSurface: _white,
    onError: _black,
    brightness: Brightness.dark,
  ),
);

class _Dark {
  _Dark._();

  static const background = Color(0xFF121212);
  static const amber300 = Color(0xFFFFD54F);
  static const amber800 = Color(0xFFFF8F00);
  static const lightGreen300 = Color(0xFFAED581);
  static const lightGreen900 = Color(0xFF558B2F);
  static const red300 = Color(0xFFE57373);
  static const gray900 = Color(0xFF212121);
  static const amber200 = Color(0xFFFFE082);
  static const deepOrange300 = Color(0xFFFF8A65);
  static const green300 = Color(0xFF81C784);
}

final _darkPrimarySwatch = Lazy(creator: () => Colors.lightGreen);