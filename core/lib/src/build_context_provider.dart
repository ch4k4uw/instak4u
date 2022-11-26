import './common/provider.dart';
import 'package:flutter/material.dart';

class BuildContextProvider extends Provider<BuildContext> {
  BuildContext _context;

  BuildContextProvider({required BuildContext context})
      : _context = context,
        super(creator: () => context);

  BuildContext get context => _context;
  set context(BuildContext value) {
    _context = value;
    notifyListeners();
  }
}
