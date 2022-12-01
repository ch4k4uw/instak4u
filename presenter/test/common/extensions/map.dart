import 'package:core/common.dart';

extension MapExtension<K, V> on Map<K, V> {
  V getOrPut(K key, V Function() creator) {
    return this[key] ?? creator().also((it) => this[key] = it);
  }
}