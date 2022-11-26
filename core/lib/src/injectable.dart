import './common/provider.dart';
import 'package:flutter/material.dart';

import './injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'build_context_provider.dart';

@InjectableInit(initializerName: r'$initCoreGetIt')
void configureCoreDependencies(
  GetIt getIt,
  BuildContext context,
  void Function() next,
) {
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
    return;
  }
  $initCoreGetIt(getIt);
  next();
}
