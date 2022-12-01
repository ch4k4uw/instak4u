import 'dart:async';

import 'package:core/common.dart';

class UnawaitedFutureRunner implements FutureRunner {
  final List<Future Function()> _actions = List.empty(growable: true);

  @override
  StreamController<T> createStreamController<T>() => StreamController(
        sync: true,
      );

  @override
  void runFuture(Future Function() action) {
    _actions.add(action);
  }

  void advanceUntilIdle() {
    while (_actions.isNotEmpty) {
      final action = _actions.removeAt(0);
      unawaited(action());
    }
  }
}
