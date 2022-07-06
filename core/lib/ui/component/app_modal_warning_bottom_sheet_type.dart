import 'package:flutter/material.dart';

enum AppModalWarningBottomSheetType {
  warning(Icons.warning),
  error(Icons.close),
  info(Icons.info),
  question(Icons.question_answer);

  final IconData icon;

  const AppModalWarningBottomSheetType(this.icon);
}
