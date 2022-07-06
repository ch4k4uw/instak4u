import 'dart:io';
import 'dart:math';

import 'package:core/common/extensions/object_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class AppScreenInfoData {
  bool get isLandscape;

  Size get size;

  double get width;

  double get height;

  double get diagonal;

  Size get inches;

  double get widthInches;

  double get heightInches;

  double get diagonalInches;

  @override
  operator ==(Object other);

  @override
  int get hashCode;
}

class AppScreenInfo extends StatefulWidget {
  final Widget child;

  const AppScreenInfo({super.key, required this.child});

  static AppScreenInfoData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritedWidget>()!.data;

  @override
  State<StatefulWidget> createState() => _AppScreenInfoState();
}

class _AppScreenInfoState extends State<AppScreenInfo>
    implements AppScreenInfoData {

  @override
  late bool isLandscape;

  @override
  late Size size;

  late double _ppi;

  @override
  Widget build(BuildContext context) {
    Widget buildWidget(MediaQueryData mediaQuery, BuildContext context) {
      return LayoutBuilder(builder: (context, constraints) {
        isLandscape = mediaQuery.orientation == Orientation.landscape;
        size = Size(constraints.biggest.width, constraints.biggest.height);
        _ppi = mediaQuery.devicePixelRatio * 160;
        return _InheritedWidget(data: this, child: widget.child);
      });
    }

    Widget? buildExpected() => MediaQuery.maybeOf(context)?.let(
          (it) => buildWidget(it, context),
        );

    Widget buildFallback() => MediaQuery.fromWindow(
          child: Builder(
            builder: (context) => buildWidget(MediaQuery.of(context), context),
          ),
        );

    return buildExpected() ?? buildFallback();
  }

  @override
  double get diagonal =>
      sqrt((size.width * size.width) + (size.height * size.height));

  @override
  double get width => size.width;

  @override
  double get height => size.height;

  @override
  Size get inches => Size(width / _ppi, height / _ppi);

  @override
  double get heightInches => inches.height;

  @override
  double get widthInches => inches.width;

  @override
  double get diagonalInches => diagonal / _ppi;

  @override
  bool operator ==(Object other) {
    if (other is! AppScreenInfoData) {
      return false;
    }
    return isLandscape != other.isLandscape || size != other.size;
  }

  @override
  int get hashCode => Object.hash(isLandscape.hashCode, size.hashCode);
}

class _InheritedWidget extends InheritedWidget {
  final AppScreenInfoData data;

  const _InheritedWidget({required this.data, required super.child});

  @override
  bool updateShouldNotify(_InheritedWidget oldWidget) {
    return data != oldWidget.data;
  }
}
