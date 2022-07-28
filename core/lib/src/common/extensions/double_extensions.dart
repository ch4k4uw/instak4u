import '../lazy.dart';
import 'package:intl/intl.dart';

final brNumberFormat = Lazy(
  creator: () => NumberFormat.simpleCurrency(locale: "pt_Br"),
);

extension LocalNumberFormat on double {
  String toPtBrCurrencyString() => brNumberFormat.value.format(this);
}
