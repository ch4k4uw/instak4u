import 'dart:async';

abstract class FutureRunner {
  factory FutureRunner.sequential() = _SeqFutureRunner;

  factory FutureRunner.nonSequential() = _NonSeqFutureRunner;

  void runFuture(Future Function() action);

  StreamController<T> createStreamController<T>();
}

class _StreamControllerFutureRunner {
  StreamController<T> createStreamController<T>() => StreamController<T>();
}

class _SeqFutureRunner
    with _StreamControllerFutureRunner
    implements FutureRunner {
  final List<Future Function()> _futureQueue = List.empty(growable: true);

  @override
  void runFuture(Future Function() action) {
    final immediate = _futureQueue.isEmpty;
    _futureQueue.add(action);
    _runNext(immediate: immediate);
  }

  Future _runNext({required bool immediate}) async {
    if (immediate) {
      await _futureQueue[0]();
      _futureQueue.removeAt(0);
      if (_futureQueue.isNotEmpty) {
        _runNext(immediate: immediate);
      }
    }
  }
}

class _NonSeqFutureRunner
    with _StreamControllerFutureRunner
    implements FutureRunner {
  @override
  void runFuture(Future Function() action) {
    action();
  }
}
