import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

@InjectableInit(initializerName: r'$initPresenterGetIt')
void configurePresenterDependencies(GetIt getIt) => $initPresenterGetIt(getIt);