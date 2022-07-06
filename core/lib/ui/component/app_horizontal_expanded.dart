import 'package:flutter/widgets.dart';

class AppHorizontalExpanded extends StatelessWidget {
  final Widget child;

  const AppHorizontalExpanded({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
      ],
    );
  }
}
