import 'package:core/common.dart';

abstract class MainUiState {}

class UpdateCounter extends MainUiState {
  final int counter;

  UpdateCounter({required this.counter});
}

abstract class MainViewModel extends AppViewModel<MainUiState> {
  factory MainViewModel({FutureRunner? futureRunner}) = _MainViewModelImpl;

  void increaseCounter();

  void decreaseCounter();
}

class _MainViewModelImpl extends AppBaseViewModel<MainUiState>
    implements MainViewModel {
  var _counter = 0;

  _MainViewModelImpl({FutureRunner? futureRunner})
      : super(futureRunner: futureRunner) {
    send(UpdateCounter(counter: -1));
  }

  @override
  void increaseCounter() {
    runFuture(() async {
      ++_counter;
      send(UpdateCounter(counter: _counter));
    });
  }

  @override
  void decreaseCounter() {
    runFuture(() async {
      --_counter;
      send(UpdateCounter(counter: _counter));
    });
  }
}
