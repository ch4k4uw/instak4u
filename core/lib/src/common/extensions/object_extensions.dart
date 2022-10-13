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
