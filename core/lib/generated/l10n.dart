// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unexpected error`
  String get genericErrorTitle {
    return Intl.message(
      'Unexpected error',
      name: 'genericErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error has occurred.\nPlease try again later`
  String get genericErrorMessage {
    return Intl.message(
      'An unexpected error has occurred.\nPlease try again later',
      name: 'genericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `TRY AGAIN`
  String get genericErrorPositiveButton {
    return Intl.message(
      'TRY AGAIN',
      name: 'genericErrorPositiveButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get genericErrorNegativeButton {
    return Intl.message(
      'Cancel',
      name: 'genericErrorNegativeButton',
      desc: '',
      args: [],
    );
  }

  /// `Connectivity error`
  String get connectivityErrorTitle {
    return Intl.message(
      'Connectivity error',
      name: 'connectivityErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error has occurred.\nPlease try again later`
  String get connectivityErrorMessage {
    return Intl.message(
      'An unexpected error has occurred.\nPlease try again later',
      name: 'connectivityErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `TRY AGAIN`
  String get connectivityErrorPositiveButton {
    return Intl.message(
      'TRY AGAIN',
      name: 'connectivityErrorPositiveButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get connectivityErrorNegativeButton {
    return Intl.message(
      'Cancel',
      name: 'connectivityErrorNegativeButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
