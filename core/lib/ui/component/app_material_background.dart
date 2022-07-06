import 'package:core/common/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class AppMaterialBackground extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const AppMaterialBackground({
    Key? key,
    this.backgroundColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? context.appTheme.colors.colorScheme.background,
      child: child,
    );
  }
}
