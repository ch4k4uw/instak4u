extension DynamicOrThrow on dynamic {
  dynamic orThrow() => let((it) {
    if (it == null) {
      throw Exception("must not be null");
    }
    return it;
  });
}