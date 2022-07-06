import 'package:core/common/view_model/future_runner.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ViewModelModule {
  @factoryMethod
  FutureRunner getFutureRunner() => FutureRunner.nonSequential();
}
