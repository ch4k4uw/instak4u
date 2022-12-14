import 'package:flutter/foundation.dart';

extension ObjectLet<T> on T {
  R let<R>(R Function(T it) creator) {
    return creator(this);
  }
}

extension ObjectAlso<T> on T {
  T also(void Function(T it) action) {
    action(this);
    return this;
  }
}

extension ObjectTakeIf<T> on T {
  T? takeIf(bool Function(T it) creator) {
    return creator(this) ? this : null;
  }
}

extension ObjectOrThrow<T, R> on T? {
  R orThrow() => let((it) {
        if (it == null) {
          throw Exception("must not be null");
        }
        return it as R;
      });
}

extension ObjectOrElse<T> on T? {
  T orElse(T elseValue) => this ?? elseValue;
}

extension ObjectSynchronousFuture<T> on T {
  SynchronousFuture<T> get asSynchronousFuture => SynchronousFuture(this);
}

extension ObjectToDouble<T> on T? {
  double doubleOrThrow() => let((it) {
    if (it == null) {
      throw Exception("must not be null");
    }
    if (it is int) {
      return it.toDouble();
    }
    return it as double;
  });
}