import 'package:flutter/foundation.dart';

class Provider<T> extends ChangeNotifier {
  final T Function() _creator;
  Provider({required T Function() creator}) : _creator = creator;

  T get value => _creator();
}