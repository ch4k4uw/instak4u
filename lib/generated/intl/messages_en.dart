// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("Instak4u"),
        "emailHint": MessageLookupByLibrary.simpleMessage("email"),
        "eventDetailsSuccessfulCheckedInMessageDescription":
            MessageLookupByLibrary.simpleMessage("Successful checked-in"),
        "eventDetailsSuccessfulCheckedInMessagePrimaryButton":
            MessageLookupByLibrary.simpleMessage("OK"),
        "eventDetailsSuccessfulCheckedInMessageTitle":
            MessageLookupByLibrary.simpleMessage("Event detail"),
        "eventOptionsCheckInAction":
            MessageLookupByLibrary.simpleMessage("Check-in"),
        "eventOptionsMapsAction": MessageLookupByLibrary.simpleMessage("Maps"),
        "eventOptionsShareAction":
            MessageLookupByLibrary.simpleMessage("Share"),
        "logoutAction": MessageLookupByLibrary.simpleMessage("Logout"),
        "nameHint": MessageLookupByLibrary.simpleMessage("name"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("password"),
        "pleaseWaitPrompt":
            MessageLookupByLibrary.simpleMessage("Please wait…"),
        "registerAction": MessageLookupByLibrary.simpleMessage("Register"),
        "signInAction": MessageLookupByLibrary.simpleMessage("Sign-in"),
        "signInInvalidUserOrPassErrorDescription":
            MessageLookupByLibrary.simpleMessage("Invalid user or password"),
        "signInInvalidUserOrPassErrorPositiveAction":
            MessageLookupByLibrary.simpleMessage("OK"),
        "signInInvalidUserOrPassErrorTitle":
            MessageLookupByLibrary.simpleMessage("Sign-in"),
        "signUpDuplicatedEmailErrorPrompt":
            MessageLookupByLibrary.simpleMessage("E-mail already registered!"),
        "signUpInvalidEmailErrorPrompt":
            MessageLookupByLibrary.simpleMessage("Invalid email!"),
        "signUpInvalidNameErrorPrompt":
            MessageLookupByLibrary.simpleMessage("Invalid name!"),
        "signUpInvalidPasswordErrorPrompt":
            MessageLookupByLibrary.simpleMessage("Invalid password!"),
        "signUpPasswordsMustMatchErrorPrompt":
            MessageLookupByLibrary.simpleMessage("password must match!"),
        "submitAction": MessageLookupByLibrary.simpleMessage("Submit")
      };
}
