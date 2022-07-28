import 'package:flutter/material.dart';

class AppContentLoadingProgressBar extends StatelessWidget {
  final bool showProgress;
  final Widget child;

  const AppContentLoadingProgressBar({
    Key? key,
    this.showProgress = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: showProgress,
          child: Container(
            color: const Color(0x77000000),
            child: const Center(child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }
}
