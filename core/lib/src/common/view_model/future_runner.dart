abstract class FutureRunner {
  void runFuture(Future Function() action);
  factory FutureRunner.sequential() = _SeqFutureRunner;
  factory FutureRunner.nonSequential() = _NonSeqFutureRunner;
}

class _SeqFutureRunner implements FutureRunner {
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

class _NonSeqFutureRunner implements FutureRunner {
  @override
  void runFuture(Future Function() action) {
    action();
  }
}