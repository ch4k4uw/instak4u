import '../app_theme.dart';
import '../component/app_modal_warning_bottom_sheet_type.dart';
import 'package:flutter/material.dart';

import 'app_horizontal_expanded.dart';

class AppModalWarningBottomSheetContent extends StatelessWidget {
  final String title;
  final String message;
  final AppModalWarningBottomSheetType type;
  final String? positiveButtonLabel;
  final void Function()? onPositiveClick;
  final String? negativeButtonLabel;
  final void Function()? onNegativeClick;

  const AppModalWarningBottomSheetContent({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.positiveButtonLabel,
    this.onPositiveClick,
    this.negativeButtonLabel,
    this.onNegativeClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    Color parseColor() {
      switch (type) {
        case AppModalWarningBottomSheetType.warning:
          return theme.colors.alertWarning;
        case AppModalWarningBottomSheetType.error:
          return theme.colors.alertError;
        case AppModalWarningBottomSheetType.info:
          return theme.colors.alertInfo;
        case AppModalWarningBottomSheetType.question:
          return theme.colors.alertQuestion;
      }
    }

    return _Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Header(icon: type.icon, title: title),
          _Body(
            color: parseColor(),
            message: message,
            positiveButtonLabel: positiveButtonLabel,
            onPositiveClick: onPositiveClick,
            negativeButtonLabel: negativeButtonLabel,
            onNegativeClick: onNegativeClick,
          )
        ],
      ),
    );
  }
}

class _Container extends StatelessWidget {
  final Widget child;

  const _Container({required this.child});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        AppHorizontalExpanded(child: child),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final IconData _icon;
  final String _title;

  const _Header({
    required String title,
    required IconData icon,
  })  : _icon = icon,
        _title = title;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final textTheme = theme.textTheme;
    final dimens = theme.dimens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: dimens.spacing.xxnormal,
        ),
        Icon(
          _icon,
          size: dimens.sizing.xnormal,
        ),
        SizedBox(
          height: dimens.spacing.xnormal,
        ),
        Text(
          _title,
          style: textTheme.headline5,
        ),
        SizedBox(
          height: dimens.spacing.normal,
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final Color color;
  final String message;
  final String? positiveButtonLabel;
  final void Function()? onPositiveClick;
  final String? negativeButtonLabel;
  final void Function()? onNegativeClick;

  const _Body({
    required this.color,
    required this.message,
    this.positiveButtonLabel,
    this.onPositiveClick,
    this.negativeButtonLabel,
    this.onNegativeClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final dimens = theme.dimens;

    return AppHorizontalExpanded(
      child: Container(
        color: theme.colors.colorScheme.onSurface.withOpacity(
            theme.doubles.defaultOpacity
        ),
        child: Row(
          children: [
            SizedBox(width: dimens.spacing.normal),
            Expanded(
              child: _BodyContent(
                color: color,
                message: message,
                positiveButtonLabel: positiveButtonLabel,
                onPositiveClick: onPositiveClick,
                negativeButtonLabel: negativeButtonLabel,
                onNegativeClick: onNegativeClick,
              ),
            ),
            SizedBox(width: dimens.spacing.normal),
          ],
        ),
      ),
    );
  }
}

class _BodyContent extends StatelessWidget {
  final Color color;
  final String message;
  final String? positiveButtonLabel;
  final void Function()? onPositiveClick;
  final String? negativeButtonLabel;
  final void Function()? onNegativeClick;

  const _BodyContent({
    Key? key,
    required this.color,
    required this.message,
    this.positiveButtonLabel,
    this.onPositiveClick,
    this.negativeButtonLabel,
    this.onNegativeClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final textTheme = theme.textTheme;
    final dimens = theme.dimens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.all(Radius.circular(dimens.shapeCorner.medium)),
          ),
          height: dimens.spacing.tiny,
        ),
        SizedBox(
          height: dimens.spacing.xxnormal,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.subtitle1,
        ),
        SizedBox(
          height: dimens.spacing.xxnormal,
        ),
        Visibility(
          visible: positiveButtonLabel != null,
          child: AppHorizontalExpanded(
            child: ElevatedButton(
              onPressed: onPositiveClick,
              style: _elevatedButtonStyle,
              child: Text(positiveButtonLabel ?? ""),
            ),
          ),
        ),
        Visibility(
          visible: positiveButtonLabel != null && negativeButtonLabel != null,
          child: SizedBox(
            height: dimens.spacing.xtiny,
          ),
        ),
        Visibility(
          visible: negativeButtonLabel != null,
          child: AppHorizontalExpanded(
            child: OutlinedButton(
              onPressed: onNegativeClick,
              style: _outlinedButtonStyle,
              child: Text(negativeButtonLabel ?? ""),
            ),
          ),
        ),
        SizedBox(
          height: dimens.spacing.xxnormal,
        ),
      ],
    );
  }
}

final _elevatedButtonStyle = ElevatedButton.styleFrom(
  shape: const StadiumBorder(),
);

final _outlinedButtonStyle = OutlinedButton.styleFrom(
  shape: const StadiumBorder(),
);
