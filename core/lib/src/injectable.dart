import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../common.dart';
import './injectable.config.dart';
import 'build_context_provider.dart';

@InjectableInit(initializerName: r'$initCoreGetIt')
void configureCoreDependencies(
  GetIt getIt,
  EnvironmentFilter environmentFilter,
) =>
    getIt.$initCoreGetIt(environmentFilter: environmentFilter);

void injectBuildContext({required BuildContext context}) {
  if (!GetIt.I.isRegistered(instance: context)) {
    final provider = BuildContextProvider(context: context);
    GetIt.I.registerSingleton<BuildContext>(provider.context);
    GetIt.I.registerSingleton<BuildContextProvider>(provider);
    GetIt.I.registerSingleton<Provider<BuildContext>>(provider);
  } else {
    final currContext = GetIt.I.get<BuildContextProvider>();
    if (currContext.context != context) {
      GetIt.I.unregister(instance: currContext.context);
      currContext.context = context;
      GetIt.I.registerSingleton<BuildContext>(currContext.context);
    }
  }
}