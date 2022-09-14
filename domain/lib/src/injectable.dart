import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

@InjectableInit(initializerName: r'$initDomainGetIt')
void configureDomainDependencies(GetIt getIt) => $initDomainGetIt(getIt);