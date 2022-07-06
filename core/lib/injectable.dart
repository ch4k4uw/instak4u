import 'package:core/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: r'$initCoreGetIt')
void configureCoreDependencies(GetIt getIt) => $initCoreGetIt(getIt);