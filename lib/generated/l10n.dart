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

  /// `Instak4u`
  String get appName {
    return Intl.message(
      'Instak4u',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Sign-in`
  String get signInInvalidUserOrPassErrorTitle {
    return Intl.message(
      'Sign-in',
      name: 'signInInvalidUserOrPassErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Invalid user or password`
  String get signInInvalidUserOrPassErrorDescription {
    return Intl.message(
      'Invalid user or password',
      name: 'signInInvalidUserOrPassErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get signInInvalidUserOrPassErrorPositiveAction {
    return Intl.message(
      'OK',
      name: 'signInInvalidUserOrPassErrorPositiveAction',
      desc: '',
      args: [],
    );
  }

  /// `Invalid name!`
  String get signUpInvalidNameErrorPrompt {
    return Intl.message(
      'Invalid name!',
      name: 'signUpInvalidNameErrorPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email!`
  String get signUpInvalidEmailErrorPrompt {
    return Intl.message(
      'Invalid email!',
      name: 'signUpInvalidEmailErrorPrompt',
      desc: '',
      args: [],
    );
  }

  /// `E-mail already registered!`
  String get signUpDuplicatedEmailErrorPrompt {
    return Intl.message(
      'E-mail already registered!',
      name: 'signUpDuplicatedEmailErrorPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password!`
  String get signUpInvalidPasswordErrorPrompt {
    return Intl.message(
      'Invalid password!',
      name: 'signUpInvalidPasswordErrorPrompt',
      desc: '',
      args: [],
    );
  }

  /// `password must match!`
  String get signUpPasswordsMustMatchErrorPrompt {
    return Intl.message(
      'password must match!',
      name: 'signUpPasswordsMustMatchErrorPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Sign-in`
  String get signInAction {
    return Intl.message(
      'Sign-in',
      name: 'signInAction',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerAction {
    return Intl.message(
      'Register',
      name: 'registerAction',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get emailHint {
    return Intl.message(
      'email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get passwordHint {
    return Intl.message(
      'password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get nameHint {
    return Intl.message(
      'name',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitAction {
    return Intl.message(
      'Submit',
      name: 'submitAction',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutAction {
    return Intl.message(
      'Logout',
      name: 'logoutAction',
      desc: '',
      args: [],
    );
  }

  /// `Event detail`
  String get eventDetailsSuccessfulCheckedInMessageTitle {
    return Intl.message(
      'Event detail',
      name: 'eventDetailsSuccessfulCheckedInMessageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Successful checked-in`
  String get eventDetailsSuccessfulCheckedInMessageDescription {
    return Intl.message(
      'Successful checked-in',
      name: 'eventDetailsSuccessfulCheckedInMessageDescription',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get eventDetailsSuccessfulCheckedInMessagePrimaryButton {
    return Intl.message(
      'OK',
      name: 'eventDetailsSuccessfulCheckedInMessagePrimaryButton',
      desc: '',
      args: [],
    );
  }

  /// `Check-in`
  String get eventOptionsCheckInAction {
    return Intl.message(
      'Check-in',
      name: 'eventOptionsCheckInAction',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get eventOptionsShareAction {
    return Intl.message(
      'Share',
      name: 'eventOptionsShareAction',
      desc: '',
      args: [],
    );
  }

  /// `Maps`
  String get eventOptionsMapsAction {
    return Intl.message(
      'Maps',
      name: 'eventOptionsMapsAction',
      desc: '',
      args: [],
    );
  }

  /// `Please wait…`
  String get pleaseWaitPrompt {
    return Intl.message(
      'Please wait…',
      name: 'pleaseWaitPrompt',
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
