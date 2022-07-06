abstract class EventComponentTransitionConstants {
  /// The point in the transition where the transformation will start. If 1, it
  /// will start at the end of the transition. The closer this value is to 0,
  /// the transformation will start earlier.
  double get transformFraction;

  /// The Scale of the transformation fraction where 1 will reflect the transition
  /// tween. So if 1, the transformation will start at the [transformFraction]
  /// and will end at the end of the transition. And if 0, the transformation
  /// will finish just after the [transformFraction].
  double get transformScale;

  /// See more: [transformFraction].
  double get alphaFraction;

  /// See more: [transformScale].
  double get alphaScale;

  /// See more: [transformFraction].
  double get titleFraction;

  /// See more: [transformScale].
  double get titleScale;
}

class EventComponentConstants {
  static const topBarHScreenFraction = .4;
  static const transitions = _TransitionConstants();
  static const largeScreenDetailsContentTopWeight = .2;
  static const largeScreenDetailsContentHorizontalWeight = .2;
  static const largeScreenDetailsContentMiddleWeight = .6;
  static const largeScreenDetailsCoverImageHeightFraction = .7;
}

class _TransitionConstants implements EventComponentTransitionConstants {
  @override
  final double alphaFraction = .45;

  @override
  final double alphaScale = .2;

  @override
  final double transformFraction = .4;

  @override
  final double transformScale = .4;

  @override
  final double titleFraction = .6;

  @override
  final double titleScale = .2;

  const _TransitionConstants();
}

extension TransitionTransitionExtension on EventComponentTransitionConstants {
  double lerpTransformation({required double transition}) {
    return _lerp(transition, transformFraction, transformScale);
  }

  double lerpAlpha({required double transition}) {
    return _lerp(transition, alphaFraction, alphaScale);
  }

  double lerpTitle({required double transition}) {
    return _lerp(transition, titleFraction, titleScale);
  }

  double _lerp(double transition, double fraction, double scale) {
    return ((transition - fraction) / scale).clamp(0, 1);
  }
}
