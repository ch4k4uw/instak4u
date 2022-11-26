import 'package:flutter/material.dart';

import '../../generated/l10n.dart' as presenter_intl;

extension PresenterString on BuildContext {
  presenter_intl.S get presenterString => presenter_intl.S.of(this);
}