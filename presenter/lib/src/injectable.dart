import 'package:domain/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

@InjectableInit(initializerName: r'$initPresenterGetIt')
void configurePresenterDependencies(
  GetIt getIt,
  EnvironmentFilter environmentFilter,
) {
  configureDomainDependencies(getIt, environmentFilter);
  $initPresenterGetIt(getIt, environmentFilter: environmentFilter);
}
