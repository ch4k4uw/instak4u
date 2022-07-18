import 'dart:async';

import 'package:core/common/extensions/object_extensions.dart';
import 'package:core/ui/app_colors.dart';
import 'package:core/ui/color/color_constants.dart';
import 'package:core/ui/component/app_screen_info.dart';
import 'package:core/ui/dimens/dimens_constants.dart';
import 'package:core/ui/typography/typography_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'app_theme_data.dart';

class AppTheme extends StatefulWidget {
  final Widget home;
  final Brightness? brightness;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  const AppTheme({
    super.key,
    required this.home,
    this.brightness,
    this.systemUiOverlayStyle,
  });

  static AppThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritedTheme>().let((it) {
        assert(it != null, "ancestor ${(AppTheme).runtimeType} not found");
        return it!.data;
      });

  static const maxSmallScreenWidth = 600.0;

  @override
  State<StatefulWidget> createState() => _AppThemeState();
}

extension AppThemeDoubleEx on double {
  bool get isLarge => this > AppTheme.maxSmallScreenWidth;
  double get largeFactor => AppTheme.maxSmallScreenWidth / this;
}

abstract class AppThemeController {
  void resetSystemUiOverlayStyle({bool updateSystemChrome = false});

  void switchSystemUiOverlayToDarkStyle({
    Color? statusBarColor,
    bool updateSystemChrome = false,
  });

  void switchSystemUiOverlayToLightStyle({
    Color? statusBarColor,
    bool updateSystemChrome = false,
  });

  static AppThemeController? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<_InheritedTheme>()!.controller;
}

class _AppThemeState extends State<AppTheme> implements AppThemeController {
  AppThemeData? _data;

  AppThemeData get data => _data.let((it) {
        if (it == null) {
          throw Exception("app theme not initialized yet");
        }
        return it;
      });

  SystemUiOverlayStyle? _systemUiOverlayStyle;

  @override
  void initState() {
    super.initState();
    _systemUiOverlayStyle = widget.systemUiOverlayStyle;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final dimens = normalAppDimens.value;
        final typography = normalTypography.value;
        final colors = _brightness.colors;
        final systemUiOverlayStyle =
            _systemUiOverlayStyle ?? _createSystemUiOverlayStyle();
        final isLarge = constraints.maxWidth.isLarge;

        _data = AppThemeData(
          colors: colors,
          dimens: dimens,
          typography: typography,
          systemOverlayStyle: systemUiOverlayStyle,
          bottomSheetTheme: constraints.takeIf((it) => isLarge)?.let(
                (it) => const BottomSheetThemeData(
                  constraints: BoxConstraints(
                    maxWidth: AppTheme.maxSmallScreenWidth,
                  ),
                ),
              ),
        );

        return _InheritedTheme(
          controller: this,
          data: data,
          child: AppScreenInfo(child: widget.home),
        );
      },
    );
  }

  Brightness get _brightness => widget.brightness ?? _platformBrightness;

  SystemUiOverlayStyle? _createSystemUiOverlayStyle({
    Brightness? brightness,
    Color? statusBarColor,
  }) {
    final mBrightness = brightness ?? _brightness;
    final colors = mBrightness.colors;
    final mStatusBarColor =
        statusBarColor ?? colors.colorScheme.primaryContainer;
    return colors.statusBarBrightness?.style?.let(
      (it) => it.copyWith(statusBarColor: mStatusBarColor),
    );
  }

  @override
  void resetSystemUiOverlayStyle({bool updateSystemChrome = false}) {
    scheduleMicrotask(() {
      setState(() {
        _systemUiOverlayStyle = widget.systemUiOverlayStyle;
        if (updateSystemChrome) {
          _createSystemUiOverlayStyle()
              ?.also(SystemChrome.setSystemUIOverlayStyle);
        }
      });
    });
  }

  @override
  void switchSystemUiOverlayToDarkStyle({
    Color? statusBarColor,
    bool updateSystemChrome = false,
  }) {
    _switchSystemUiOverlayTo(
      brightness: Brightness.dark,
      statusBarColor: statusBarColor,
      updateSystemChrome: updateSystemChrome,
    );
  }

  @override
  void switchSystemUiOverlayToLightStyle({
    Color? statusBarColor,
    bool updateSystemChrome = false,
  }) {
    _switchSystemUiOverlayTo(
      brightness: Brightness.light,
      statusBarColor: statusBarColor,
      updateSystemChrome: updateSystemChrome,
    );
  }

  void _switchSystemUiOverlayTo({
    required Brightness brightness,
    Color? statusBarColor,
    bool updateSystemChrome = false,
  }) {
    scheduleMicrotask(() {
      setState(() {
        _systemUiOverlayStyle = _createSystemUiOverlayStyle(
          brightness: brightness,
          statusBarColor: statusBarColor,
        );
        final overlay = _systemUiOverlayStyle;
        if (updateSystemChrome && overlay != null) {
          SystemChrome.setSystemUIOverlayStyle(overlay);
        }
      });
    });
  }
}

Brightness get _platformBrightness =>
    SchedulerBinding.instance.window.platformBrightness;

extension _BrightnessToAppColors on Brightness {
  AppColors get colors =>
      this == Brightness.dark ? darkColors.value : lightColors.value;
}

extension _BrightnessToSystemUiOverlayStyle on Brightness? {
  SystemUiOverlayStyle? get style => this?.let(_toSystemUiOverlayStyle);
}

SystemUiOverlayStyle _toSystemUiOverlayStyle(Brightness it) =>
    it == Brightness.dark
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

class _InheritedTheme extends InheritedWidget {
  final AppThemeController controller;
  final AppThemeData data;

  const _InheritedTheme({
    required this.controller,
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedTheme oldWidget) => data != oldWidget.data;
}
