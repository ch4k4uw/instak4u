import './future_runner.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ViewModelModule {
  @factoryMethod
  FutureRunner getFutureRunner() => FutureRunner.nonSequential();
}
