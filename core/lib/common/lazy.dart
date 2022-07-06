export 'dart:js'
if (dart.library.js) 'dart:js';
class Lazy<T> {
  final T Function() _creator;
  late T _value;
  var _isInitialized = false;

  Lazy({required T Function() creator}) : _creator = creator;

  T get value {
    if (!_isInitialized) {
      _value = _creator();
      _isInitialized = true;
    }
    return _value;
  }
}