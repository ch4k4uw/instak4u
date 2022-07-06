import 'package:core/common/extensions/build_context_extensions.dart';
import 'package:core/ui/component/app_horizontal_expanded.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';

extension ProfileBottomSheet on BuildContext {
  void showProfileBottomSheet({
    required String name,
    required String email,
    required void Function() onLogoutClick,
  }) {
    showAppModalBottomSheet(
      content: (_) => _ProfileBottomSheetContent(
        name: name,
        email: email,
        onLogoutClick: onLogoutClick,
      ),
    );
  }
}

class _ProfileBottomSheetContent extends StatelessWidget {
  final String name;
  final String email;
  final void Function() onLogoutClick;

  const _ProfileBottomSheetContent({
    Key? key,
    required this.name,
    required this.email,
    required this.onLogoutClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          children: [
            const _SheetHorizontalMargin(),
            Expanded(
              child: Column(
                children: [
                  ...context._sheetTitle(),
                  ...context._sheetBody(name: name, email: email),
                  ...context._logoutButton(
                    onClick: () {
                      Navigator.pop(context);
                      onLogoutClick();
                    },
                  )
                ],
              ),
            ),
            const _SheetHorizontalMargin()
          ],
        )
      ],
    );
  }
}

class _SheetHorizontalMargin extends StatelessWidget {
  const _SheetHorizontalMargin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = context.appTheme.dimens;
    return SizedBox(width: dimens.spacing.normal);
  }
}

extension _Widgets on BuildContext {
  List<Widget> _sheetTitle() {
    final dimens = appTheme.dimens;
    final textTheme = appTheme.textTheme;
    return [
      SizedBox(height: dimens.spacing.xtiny),
      AppHorizontalExpanded(
        child: Text(
          appString.appName,
          textAlign: TextAlign.center,
          style: textTheme.headline5,
        ),
      )
    ];
  }

  List<Widget> _sheetBody({required String name, required String email}) {
    final dimens = appTheme.dimens;
    final textTheme = appTheme.textTheme;
    return [
      SizedBox(height: dimens.spacing.large),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.person),
          SizedBox(
            width: dimens.spacing.small,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: textTheme.bodyText2),
              Text(email, style: textTheme.caption)
            ],
          )
        ],
      )
    ];
  }

  List<Widget> _logoutButton({required void Function() onClick}) {
    final dimens = appTheme.dimens;
    return [
      SizedBox(height: dimens.spacing.normal),
      AppHorizontalExpanded(
        child: FractionallySizedBox(
          alignment: Alignment.topLeft,
          widthFactor: .85,
          child: ElevatedButton(
            onPressed: onClick,
            child: Text(appString.logoutAction),
          ),
        ),
      ),
      SizedBox(height: dimens.spacing.xxnormal)
    ];
  }
}
