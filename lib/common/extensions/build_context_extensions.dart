import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'package:core/intl.dart' as core_intl;

extension AppString on BuildContext {
  S get appString => S.of(this);
}

extension CoreString on BuildContext {
  core_intl.S get coreString => core_intl.S.of(this);
}
