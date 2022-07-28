import 'dart:ui';

import '../common/extensions/diagnostic_properties_builder_extensions.dart';
import 'package:flutter/foundation.dart';

class AppDimens with Diagnosticable {
  final FontDimens font;
  final LetterSpacingDimens letterSpacing;
  final ShapeCornerDimens shapeCorner;
  final SpacingDimens spacing;
  final SizingDimens sizing;
  final PaddingDimens padding;

  const AppDimens._({
    this.font = _normalFontDimens,
    this.letterSpacing = _normalLetterSpacingDimens,
    this.shapeCorner = _normalShapeCornerDimens,
    this.spacing = _normalSpacingDimens,
    this.sizing = _normalSizingDimens,
    this.padding = _normalPaddingDimens,
  });

  const AppDimens.normal({
    this.font = _normalFontDimens,
    this.letterSpacing = _normalLetterSpacingDimens,
    this.shapeCorner = _normalShapeCornerDimens,
    this.spacing = _normalSpacingDimens,
    this.sizing = _normalSizingDimens,
    this.padding = _normalPaddingDimens,
  });

  AppDimens copyWith({
    FontDimens? font,
    LetterSpacingDimens? letterSpacing,
    ShapeCornerDimens? shapeCorner,
    SpacingDimens? spacing,
    SizingDimens? sizing,
    PaddingDimens? padding,
  }) {
    return AppDimens._(
      font: font ?? this.font,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      shapeCorner: shapeCorner ?? this.shapeCorner,
      spacing: spacing ?? this.spacing,
      sizing: sizing ?? this.sizing,
      padding: padding ?? this.padding,
    );
  }

  AppDimens lerp(AppDimens other, double t) {
    return AppDimens._(
      font: font.lerp(other.font, t),
      letterSpacing: letterSpacing.lerp(other.letterSpacing, t),
      shapeCorner: shapeCorner.lerp(other.shapeCorner, t),
      spacing: spacing.lerp(other.spacing, t),
      sizing: sizing.lerp(other.sizing, t),
      padding: padding.lerp(other.padding, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DiagnosticsProperty<FontDimens>('font', font,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<LetterSpacingDimens>('letterSpacing', letterSpacing,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<ShapeCornerDimens>('shapeCorner', shapeCorner,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<SpacingDimens>('spacing', spacing,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<SizingDimens>('sizing', sizing,
          level: DiagnosticLevel.debug),
      DiagnosticsProperty<PaddingDimens>('padding', padding,
          level: DiagnosticLevel.debug)
    ]);
  }
}

const _normalFontSizeMultiplier = 16.0 / 12.0;
const _normalFontDimens = FontDimens();

class FontDimens with Diagnosticable {
  final double h1;
  final double h2;
  final double h3;
  final double h4;
  final double h5;
  final double h6;
  final double subtitle1;
  final double subtitle2;
  final double body1;
  final double body2;
  final double button;
  final double caption;
  final double overLine;
  final double tiny;
  final double xtiny;
  final double small;
  final double xsmall;
  final double normal;
  final double xnormal;
  final double large;
  final double xlarge;
  final double huge;

  const FontDimens({
    // region 2018 spec (https://api.flutter.dev/flutter/material/TextTheme-class.html)
    this.h1 = 96.0 * _normalFontSizeMultiplier,
    this.h2 = 60.0 * _normalFontSizeMultiplier,
    this.h3 = 48.0 * _normalFontSizeMultiplier,
    this.h4 = 34.0 * _normalFontSizeMultiplier,
    this.h5 = 24.0 * _normalFontSizeMultiplier,
    this.h6 = 20.0 * _normalFontSizeMultiplier,
    this.subtitle1 = 16.0 * _normalFontSizeMultiplier,
    this.subtitle2 = 14.0 * _normalFontSizeMultiplier,
    this.body1 = 16.0 * _normalFontSizeMultiplier,
    this.body2 = 14.0 * _normalFontSizeMultiplier,
    this.button = 14.0 * _normalFontSizeMultiplier,
    this.caption = 12.0 * _normalFontSizeMultiplier,
    this.overLine = 10.0 * _normalFontSizeMultiplier,
    // endregion
    this.tiny = 8.0 * _normalFontSizeMultiplier,
    this.xtiny = 10.0 * _normalFontSizeMultiplier,
    this.small = 12.0 * _normalFontSizeMultiplier,
    this.xsmall = 14.0 * _normalFontSizeMultiplier,
    this.normal = 16.0 * _normalFontSizeMultiplier,
    this.xnormal = 20.0 * _normalFontSizeMultiplier,
    this.large = 24.0 * _normalFontSizeMultiplier,
    this.xlarge = 32.0 * _normalFontSizeMultiplier,
    this.huge = 50.0 * _normalFontSizeMultiplier,
  });

  FontDimens copyWith({
    double? h1,
    double? h2,
    double? h3,
    double? h4,
    double? h5,
    double? h6,
    double? subtitle1,
    double? subtitle2,
    double? body1,
    double? body2,
    double? button,
    double? caption,
    double? overLine,
    double? tiny,
    double? xtiny,
    double? small,
    double? xsmall,
    double? normal,
    double? xnormal,
    double? large,
    double? xlarge,
    double? huge,
  }) {
    return FontDimens(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      subtitle1: subtitle1 ?? this.subtitle1,
      subtitle2: subtitle2 ?? this.subtitle2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      button: button ?? this.button,
      caption: caption ?? this.caption,
      overLine: overLine ?? this.overLine,
      tiny: tiny ?? this.tiny,
      xtiny: xtiny ?? this.xtiny,
      small: small ?? this.small,
      xsmall: xsmall ?? this.xsmall,
      normal: normal ?? this.normal,
      xnormal: xnormal ?? this.xnormal,
      large: large ?? this.large,
      xlarge: xlarge ?? this.xlarge,
      huge: huge ?? this.huge,
    );
  }

  FontDimens lerp(FontDimens other, double t) {
    return FontDimens(
      h1: lerpDouble(h1, other.h1, t)!,
      h2: lerpDouble(h2, other.h2, t)!,
      h3: lerpDouble(h3, other.h3, t)!,
      h4: lerpDouble(h4, other.h4, t)!,
      h5: lerpDouble(h5, other.h5, t)!,
      h6: lerpDouble(h6, other.h6, t)!,
      subtitle1: lerpDouble(subtitle1, other.subtitle1, t)!,
      subtitle2: lerpDouble(subtitle2, other.subtitle2, t)!,
      body1: lerpDouble(body1, other.body1, t)!,
      body2: lerpDouble(body2, other.body2, t)!,
      button: lerpDouble(button, other.button, t)!,
      caption: lerpDouble(caption, other.caption, t)!,
      overLine: lerpDouble(overLine, other.overLine, t)!,
      tiny: lerpDouble(tiny, other.tiny, t)!,
      xtiny: lerpDouble(xtiny, other.xtiny, t)!,
      small: lerpDouble(small, other.small, t)!,
      xsmall: lerpDouble(xsmall, other.xsmall, t)!,
      normal: lerpDouble(normal, other.normal, t)!,
      xnormal: lerpDouble(xnormal, other.xnormal, t)!,
      large: lerpDouble(large, other.large, t)!,
      xlarge: lerpDouble(xlarge, other.xlarge, t)!,
      huge: lerpDouble(huge, other.huge, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DoubleProperty('h1', h1, level: DiagnosticLevel.debug),
      DoubleProperty('h2', h2, level: DiagnosticLevel.debug),
      DoubleProperty('h3', h3, level: DiagnosticLevel.debug),
      DoubleProperty('h4', h4, level: DiagnosticLevel.debug),
      DoubleProperty('h5', h5, level: DiagnosticLevel.debug),
      DoubleProperty('h6', h6, level: DiagnosticLevel.debug),
      DoubleProperty('subtitle1', subtitle1, level: DiagnosticLevel.debug),
      DoubleProperty('subtitle2', subtitle2, level: DiagnosticLevel.debug),
      DoubleProperty('body1', body1, level: DiagnosticLevel.debug),
      DoubleProperty('body2', body2, level: DiagnosticLevel.debug),
      DoubleProperty('button', button, level: DiagnosticLevel.debug),
      DoubleProperty('caption', caption, level: DiagnosticLevel.debug),
      DoubleProperty('overLine', overLine, level: DiagnosticLevel.debug),
      DoubleProperty('tiny', tiny, level: DiagnosticLevel.debug),
      DoubleProperty('xtiny', xtiny, level: DiagnosticLevel.debug),
      DoubleProperty('normal', normal, level: DiagnosticLevel.debug),
      DoubleProperty('xnormal', xnormal, level: DiagnosticLevel.debug),
      DoubleProperty('large', large, level: DiagnosticLevel.debug),
      DoubleProperty('xlarge', xlarge, level: DiagnosticLevel.debug),
      DoubleProperty('huge', huge, level: DiagnosticLevel.debug),
    ]);
  }
}

const _normalLetterSpacingMultiplier = _normalFontSizeMultiplier;
const _normalLetterSpacingDimens = LetterSpacingDimens();

class LetterSpacingDimens with Diagnosticable {
  final double h1;
  final double h2;
  final double h3;
  final double h4;
  final double h5;
  final double h6;
  final double subtitle1;
  final double subtitle2;
  final double body1;
  final double body2;
  final double button;
  final double caption;
  final double overLine;

  const LetterSpacingDimens({
    // region 2018 spec (https://api.flutter.dev/flutter/material/TextTheme-class.html)
    this.h1 = -1.5 * _normalLetterSpacingMultiplier,
    this.h2 = -0.5 * _normalLetterSpacingMultiplier,
    this.h3 = 0 * _normalLetterSpacingMultiplier,
    this.h4 = 0.25 * _normalLetterSpacingMultiplier,
    this.h5 = 0 * _normalLetterSpacingMultiplier,
    this.h6 = 0.15 * _normalLetterSpacingMultiplier,
    this.subtitle1 = 0.15 * _normalLetterSpacingMultiplier,
    this.subtitle2 = 0.1 * _normalLetterSpacingMultiplier,
    this.body1 = 0.5 * _normalLetterSpacingMultiplier,
    this.body2 = 0.25 * _normalLetterSpacingMultiplier,
    this.button = 1.25 * _normalLetterSpacingMultiplier,
    this.caption = 0.4 * _normalLetterSpacingMultiplier,
    this.overLine = 1.5 * _normalLetterSpacingMultiplier,
    // endregion
  });

  LetterSpacingDimens copyWith({
    double? h1,
    double? h2,
    double? h3,
    double? h4,
    double? h5,
    double? h6,
    double? subtitle1,
    double? subtitle2,
    double? body1,
    double? body2,
    double? button,
    double? caption,
    double? overLine,
  }) {
    return LetterSpacingDimens(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      subtitle1: subtitle1 ?? this.subtitle1,
      subtitle2: subtitle2 ?? this.subtitle2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      button: button ?? this.button,
      caption: caption ?? this.caption,
      overLine: overLine ?? this.overLine,
    );
  }

  LetterSpacingDimens lerp(LetterSpacingDimens other, double t) {
    return LetterSpacingDimens(
      h1: lerpDouble(h1, other.h1, t)!,
      h2: lerpDouble(h2, other.h2, t)!,
      h3: lerpDouble(h3, other.h3, t)!,
      h4: lerpDouble(h4, other.h4, t)!,
      h5: lerpDouble(h5, other.h5, t)!,
      h6: lerpDouble(h6, other.h6, t)!,
      subtitle1: lerpDouble(subtitle1, other.subtitle1, t)!,
      subtitle2: lerpDouble(subtitle2, other.subtitle2, t)!,
      body1: lerpDouble(body1, other.body1, t)!,
      body2: lerpDouble(body2, other.body2, t)!,
      button: lerpDouble(button, other.button, t)!,
      caption: lerpDouble(caption, other.caption, t)!,
      overLine: lerpDouble(overLine, other.overLine, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DoubleProperty('h1', h1, level: DiagnosticLevel.debug),
      DoubleProperty('h2', h2, level: DiagnosticLevel.debug),
      DoubleProperty('h3', h3, level: DiagnosticLevel.debug),
      DoubleProperty('h4', h4, level: DiagnosticLevel.debug),
      DoubleProperty('h5', h5, level: DiagnosticLevel.debug),
      DoubleProperty('h6', h6, level: DiagnosticLevel.debug),
      DoubleProperty('subtitle1', subtitle1, level: DiagnosticLevel.debug),
      DoubleProperty('subtitle2', subtitle2, level: DiagnosticLevel.debug),
      DoubleProperty('body1', body1, level: DiagnosticLevel.debug),
      DoubleProperty('body2', body2, level: DiagnosticLevel.debug),
      DoubleProperty('button', button, level: DiagnosticLevel.debug),
      DoubleProperty('caption', caption, level: DiagnosticLevel.debug),
      DoubleProperty('overLine', overLine, level: DiagnosticLevel.debug),
    ]);
  }
}

const _normalShapeCornerDimens = ShapeCornerDimens();

class ShapeCornerDimens with Diagnosticable {
  final double small;
  final double medium;
  final double large;

  const ShapeCornerDimens({
    this.small = 4,
    this.medium = 4,
    this.large = 0,
  });

  ShapeCornerDimens copyWith({
    double? small,
    double? medium,
    double? large,
  }) {
    return ShapeCornerDimens(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  ShapeCornerDimens lerp(ShapeCornerDimens other, double t) {
    return ShapeCornerDimens(
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DoubleProperty('small', small, level: DiagnosticLevel.debug),
      DoubleProperty('medium', medium, level: DiagnosticLevel.debug),
      DoubleProperty('large', large, level: DiagnosticLevel.debug),
    ]);
  }
}

const _normalSpacingDimens = SpacingDimens();

class SpacingDimens with Diagnosticable {
  final double tiny;
  final double xtiny;
  final double small;
  final double normal;
  final double xnormal;
  final double xxnormal;
  final double large;
  final double xlarge;
  final double xxlarge;
  final double huge;
  final double xhuge;
  final double xxhuge;
  final double xxlhuge;

  const SpacingDimens({
    this.tiny = 4,
    this.xtiny = 8,
    this.small = 12,
    this.normal = 16,
    this.xnormal = 20,
    this.xxnormal = 24,
    this.large = 32,
    this.xlarge = 40,
    this.xxlarge = 48,
    this.huge = 56,
    this.xhuge = 64,
    this.xxhuge = 80,
    this.xxlhuge = 96,
  });

  SpacingDimens copyWith({
    double? tiny,
    double? xtiny,
    double? small,
    double? normal,
    double? xnormal,
    double? xxnormal,
    double? large,
    double? xlarge,
    double? xxlarge,
    double? huge,
    double? xhuge,
    double? xxhuge,
    double? xxlhuge,
  }) {
    return SpacingDimens(
      tiny: tiny ?? this.tiny,
      xtiny: xtiny ?? this.xtiny,
      small: small ?? this.small,
      normal: normal ?? this.normal,
      xnormal: xnormal ?? this.xnormal,
      xxnormal: xxnormal ?? this.xxnormal,
      large: large ?? this.large,
      xlarge: xlarge ?? this.xlarge,
      xxlarge: xxlarge ?? this.xxlarge,
      huge: huge ?? this.huge,
      xhuge: xhuge ?? this.xhuge,
      xxhuge: xxhuge ?? this.xxhuge,
      xxlhuge: xxlhuge ?? this.xxlhuge,
    );
  }

  SpacingDimens lerp(SpacingDimens other, double t) {
    return SpacingDimens(
      tiny: lerpDouble(tiny, other.tiny, t)!,
      xtiny: lerpDouble(xtiny, other.xtiny, t)!,
      small: lerpDouble(small, other.small, t)!,
      normal: lerpDouble(normal, other.normal, t)!,
      xnormal: lerpDouble(xnormal, other.xnormal, t)!,
      xxnormal: lerpDouble(xxnormal, other.xxnormal, t)!,
      large: lerpDouble(large, other.large, t)!,
      xlarge: lerpDouble(xlarge, other.xlarge, t)!,
      xxlarge: lerpDouble(xxlarge, other.xxlarge, t)!,
      huge: lerpDouble(huge, other.huge, t)!,
      xhuge: lerpDouble(xhuge, other.xhuge, t)!,
      xxhuge: lerpDouble(xxhuge, other.xxhuge, t)!,
      xxlhuge: lerpDouble(xxlhuge, other.xxlhuge, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DoubleProperty('tiny', tiny, level: DiagnosticLevel.debug),
      DoubleProperty('xtiny', xtiny, level: DiagnosticLevel.debug),
      DoubleProperty('small', small, level: DiagnosticLevel.debug),
      DoubleProperty('normal', normal, level: DiagnosticLevel.debug),
      DoubleProperty('xnormal', xnormal, level: DiagnosticLevel.debug),
      DoubleProperty('xxnormal', xxnormal, level: DiagnosticLevel.debug),
      DoubleProperty('large', large, level: DiagnosticLevel.debug),
      DoubleProperty('xlarge', xlarge, level: DiagnosticLevel.debug),
      DoubleProperty('xxlarge', xxlarge, level: DiagnosticLevel.debug),
      DoubleProperty('huge', huge, level: DiagnosticLevel.debug),
      DoubleProperty('xhuge', xhuge, level: DiagnosticLevel.debug),
      DoubleProperty('xxhuge', xxhuge, level: DiagnosticLevel.debug),
      DoubleProperty('xxlhuge', xxlhuge, level: DiagnosticLevel.debug),
    ]);
  }
}

const _normalSizingDimens = SizingDimens();

class SizingDimens with Diagnosticable {
  final double tiny;
  final double xtiny;
  final double small;
  final double xsmall;
  final double normal;
  final double xnormal;
  final double large;
  final double xlarge;
  final double huge;
  final double xhuge;

  const SizingDimens({
    this.tiny = 16,
    this.xtiny = 20,
    this.small = 24,
    this.xsmall = 32,
    this.normal = 40,
    this.xnormal = 48,
    this.large = 56,
    this.xlarge = 64,
    this.huge = 72,
    this.xhuge = 90,
  });

  SizingDimens copyWith({
    double? tiny,
    double? xtiny,
    double? small,
    double? xsmall,
    double? normal,
    double? xnormal,
    double? large,
    double? xlarge,
    double? huge,
    double? xhuge,
  }) {
    return SizingDimens(
      tiny: tiny ?? this.tiny,
      xtiny: xtiny ?? this.xtiny,
      small: small ?? this.small,
      xsmall: xsmall ?? this.xsmall,
      normal: normal ?? this.normal,
      xnormal: xnormal ?? this.xnormal,
      large: large ?? this.large,
      xlarge: xlarge ?? this.xlarge,
      huge: huge ?? this.huge,
      xhuge: xhuge ?? this.xhuge,
    );
  }

  SizingDimens lerp(SizingDimens other, double t) {
    return SizingDimens(
      tiny: lerpDouble(tiny, other.tiny, t)!,
      xtiny: lerpDouble(xtiny, other.xtiny, t)!,
      small: lerpDouble(small, other.small, t)!,
      xsmall: lerpDouble(xsmall, other.xsmall, t)!,
      normal: lerpDouble(normal, other.normal, t)!,
      xnormal: lerpDouble(xnormal, other.xnormal, t)!,
      large: lerpDouble(large, other.large, t)!,
      xlarge: lerpDouble(xlarge, other.xlarge, t)!,
      huge: lerpDouble(huge, other.huge, t)!,
      xhuge: lerpDouble(xhuge, other.xhuge, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DoubleProperty('tiny', tiny, level: DiagnosticLevel.debug),
      DoubleProperty('xtiny', xtiny, level: DiagnosticLevel.debug),
      DoubleProperty('small', small, level: DiagnosticLevel.debug),
      DoubleProperty('xsmall', xsmall, level: DiagnosticLevel.debug),
      DoubleProperty('normal', normal, level: DiagnosticLevel.debug),
      DoubleProperty('xnormal', xnormal, level: DiagnosticLevel.debug),
      DoubleProperty('large', large, level: DiagnosticLevel.debug),
      DoubleProperty('xlarge', xlarge, level: DiagnosticLevel.debug),
      DoubleProperty('huge', huge, level: DiagnosticLevel.debug),
      DoubleProperty('xhuge', xhuge, level: DiagnosticLevel.debug),
    ]);
  }
}

const _normalPaddingDimens = PaddingDimens();

class PaddingDimens with Diagnosticable {
  final double tiny;
  final double small;

  const PaddingDimens({
    this.tiny = 4,
    this.small = 12,
  });

  PaddingDimens copyWith({
    double? tiny,
    double? small,
  }) {
    return PaddingDimens(
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
    );
  }

  PaddingDimens lerp(PaddingDimens other, double t) {
    return PaddingDimens(
      tiny: lerpDouble(tiny, other.tiny, t)!,
      small: lerpDouble(small, other.small, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addAll([
      DoubleProperty('tiny', tiny, level: DiagnosticLevel.debug),
      DoubleProperty('small', small, level: DiagnosticLevel.debug),
    ]);
  }
}
