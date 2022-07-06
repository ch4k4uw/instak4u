import 'package:core/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:instak4u/injectable.config.dart';
import 'package:presenter/injectable.dart';

@InjectableInit()
void configureDependencies() {
  configureCoreDependencies(GetIt.I);
  configurePresenterDependencies(GetIt.I);
  $initGetIt(GetIt.I);
}