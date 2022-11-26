import 'package:core/injectable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:instak4u/injectable.config.dart';
import 'package:presenter/injectable.dart';

@InjectableInit()
void configureDependencies({required BuildContext context}) {
  configureCoreDependencies(
    GetIt.I,
    context,
    () {
      configurePresenterDependencies(GetIt.I);
      $initGetIt(GetIt.I);
    },
  );
}
