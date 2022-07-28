import 'dart:async';

import './future_runner.dart';

abstract class AppViewModel<T> {
  Stream<T> get uiState;
  Future close();
}

abstract class AppBaseViewModel<T> implements AppViewModel<T> {
  final StreamController<T> _uiState;
  final FutureRunner _futureRunner;

  AppBaseViewModel({FutureRunner? futureRunner})
      : _uiState = StreamController<T>(),
        _futureRunner = futureRunner ?? FutureRunner.sequential();

  @override
  Stream<T> get uiState => _uiState.stream;

  @override
  Future close() async {
    return _uiState.close();
  }

  void runFuture(Future Function() action) {
    _futureRunner.runFuture(action);
  }

  void send(T state) {
    _uiState.add(state);
  }
}
