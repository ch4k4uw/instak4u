import 'package:core/common/extensions/object_extensions.dart';
import 'package:core/ui/dimens/dimens_constants.dart';
import 'package:flutter/material.dart';

import '../../common/lazy.dart';
import '../app_typography.dart';

const _robotoTextStyle = TextStyle(
  fontFamily: 'Roboto',
  decoration: TextDecoration.none,
);
const _robotoCondensedTextStyle = TextStyle(
  fontFamily: 'RobotoCondensed',
  decoration: TextDecoration.none,
);

final _normalWhiteTextTheme = Lazy(
  creator: () => TextTheme(
    headline1: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.h1,
      fontWeight: FontWeight.w300,
      letterSpacing: normalAppDimens.value.letterSpacing.h1,
      color: Colors.white70,
    ),
    headline2: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.h2,
      fontWeight: FontWeight.w300,
      letterSpacing: normalAppDimens.value.letterSpacing.h2,
      color: Colors.white70,
    ),
    headline3: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.h3,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.h3,
      color: Colors.white70,
    ),
    headline4: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.h4,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.h4,
      color: Colors.white70,
    ),
    headline5: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.h5,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.h5,
      color: Colors.white,
    ),
    headline6: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.h6,
      fontWeight: FontWeight.w500,
      letterSpacing: normalAppDimens.value.letterSpacing.h6,
      color: Colors.white,
    ),
    subtitle1: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.subtitle1,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.subtitle1,
      color: Colors.white,
    ),
    subtitle2: _robotoTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.subtitle2,
      fontWeight: FontWeight.w500,
      letterSpacing: normalAppDimens.value.letterSpacing.subtitle2,
      color: Colors.white,
    ),
    bodyText1: _robotoCondensedTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.body1,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.body1,
      color: Colors.white,
    ),
    bodyText2: _robotoCondensedTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.body2,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.body2,
      color: Colors.white,
    ),
    caption: _robotoCondensedTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.caption,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.caption,
      color: Colors.white70,
    ),
    button: _robotoCondensedTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.button,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.button,
      color: Colors.white,
    ),
    overline: _robotoCondensedTextStyle.copyWith(
      fontSize: normalAppDimens.value.font.overLine,
      fontWeight: FontWeight.normal,
      letterSpacing: normalAppDimens.value.letterSpacing.overLine,
      color: Colors.white,
    ),
  ),
);

final _normalBlackTextTheme = Lazy(
  creator: () => _normalWhiteTextTheme.value.let(
    (it) => it.copyWith(
      headline1: it.headline1!.copyWith(color: Colors.black54),
      headline2: it.headline2!.copyWith(color: Colors.black54),
      headline3: it.headline3!.copyWith(color: Colors.black54),
      headline4: it.headline4!.copyWith(color: Colors.black54),
      headline5: it.headline5!.copyWith(color: Colors.black),
      headline6: it.headline6!.copyWith(color: Colors.black),
      subtitle1: it.subtitle1!.copyWith(color: Colors.black),
      subtitle2: it.subtitle2!.copyWith(color: Colors.black),
      bodyText1: it.bodyText1!.copyWith(color: Colors.black),
      bodyText2: it.bodyText2!.copyWith(color: Colors.black),
      caption: it.caption!.copyWith(color: Colors.black54),
      button: it.button!.copyWith(color: Colors.black),
      overline: it.overline!.copyWith(color: Colors.black),
    ),
  ),
);

final normalTypography = Lazy(
  creator: () => AppTypography(
    material: Typography(
      white: _normalWhiteTextTheme.value,
      black: _normalBlackTextTheme.value,
    ),
  ),
);
