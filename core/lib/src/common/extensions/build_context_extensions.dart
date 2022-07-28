import 'dart:async';

import '../../ui/app_theme.dart';
import '../../ui/app_theme_data.dart';
import '../../ui/component/app_modal_warning_bottom_sheet_content.dart';
import '../../ui/component/app_screen_info.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../ui/component/app_modal_warning_bottom_sheet_type.dart';

extension BuildContextExtensions on BuildContext {
  void showModalGenericErrorBottomSheet({
    bool Function()? onPositiveClick,
    bool Function()? onNegativeClick,
  }) {
    showAppModalWarningBottomSheet(
      type: AppModalWarningBottomSheetType.error,
      title: S.of(this).genericErrorTitle,
      message: S.of(this).genericErrorMessage,
      onPositiveClick: onPositiveClick,
      positiveButtonLabel: S.of(this).genericErrorPositiveButton,
      onNegativeClick: onNegativeClick,
      negativeButtonLabel: S.of(this).genericErrorNegativeButton,
    );
  }

  void showModalConnectivityErrorBottomSheet({
    bool Function()? onPositiveClick,
    bool Function()? onNegativeClick,
  }) {
    showAppModalWarningBottomSheet(
      type: AppModalWarningBottomSheetType.warning,
      title: S.of(this).connectivityErrorTitle,
      message: S.of(this).connectivityErrorMessage,
      onPositiveClick: onPositiveClick,
      positiveButtonLabel: S.of(this).connectivityErrorPositiveButton,
      onNegativeClick: onNegativeClick,
      negativeButtonLabel: S.of(this).connectivityErrorNegativeButton,
    );
  }

  void showAppModalWarningBottomSheet({
    required AppModalWarningBottomSheetType type,
    required String title,
    required String message,
    String? positiveButtonLabel,
    bool Function()? onPositiveClick,
    String? negativeButtonLabel,
    bool Function()? onNegativeClick,
  }) {
    showAppModalBottomSheet(
      content: (context) => AppModalWarningBottomSheetContent(
        title: title,
        message: message,
        type: type,
        onPositiveClick: () {
          if (onPositiveClick == null || onPositiveClick()) {
            Navigator.pop(context);
          }
        },
        positiveButtonLabel: positiveButtonLabel,
        onNegativeClick: () {
          if (onNegativeClick == null || onNegativeClick()) {
            Navigator.pop(context);
          }
        },
        negativeButtonLabel: negativeButtonLabel,
      ),
    );
  }

  void showAppModalBottomSheet({
    required Widget Function(BuildContext) content,
  }) {
    final dimens = appTheme.dimens;
    var prevTheme = appTheme.data.bottomSheetTheme;
    var showModal = () {};

    showModal = () {
      showModalBottomSheet(
        context: this,
        constraints: prevTheme.constraints,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(dimens.sizing.small),
            topRight: Radius.circular(dimens.sizing.small),
          ),
        ),
        builder: (context) {
          if (prevTheme != appTheme.data.bottomSheetTheme) {
            prevTheme = appTheme.data.bottomSheetTheme;
            scheduleMicrotask(() {
              Navigator.pop(context);
              scheduleMicrotask(() => showModal());
            });
          }
          return content(context);
        },
      );
    };

    showModal();
  }

  AppThemeData get appTheme => AppTheme.of(this);

  AppScreenInfoData get screenInfo => AppScreenInfo.of(this);
}
