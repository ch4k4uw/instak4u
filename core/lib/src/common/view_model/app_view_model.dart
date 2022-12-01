import 'dart:async';

import 'package:flutter/material.dart';

import './future_runner.dart';

abstract class AppViewModel<T> {
  Stream<T> get uiState;

  Future close();
}

abstract class AppBaseViewModel<T> implements AppViewModel<T> {
  final StreamController<T> _uiState;
  final FutureRunner _futureRunner;

  AppBaseViewModel({FutureRunner? futureRunner})
      : _uiState =
            futureRunner?.createStreamController() ?? StreamController<T>(),
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

  void runFutureOrCatch(Future Function() action, Future Function() error) {
    runFuture(() async {
      try {
        await action();
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: s);
        await error();
      }
    });
  }

  void send(T state) {
    _uiState.add(state);
  }
}
