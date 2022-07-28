import 'package:core/common.dart';
import 'package:core/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';

extension EventOptionsBottomSheet on BuildContext {
  void showEventOptionsBottomSheet({
    required void Function() onCheckInClick,
    required void Function() onShareClick,
    required void Function() onMapsClick,
  }) {
    showAppModalBottomSheet(
      content: (_) => _EventOptionsBottomSheetState(
        onCheckInClick: onCheckInClick,
        onShareClick: onShareClick,
        onMapsClick: onMapsClick,
      ),
    );
  }
}

class _EventOptionsBottomSheetState extends StatelessWidget {
  final void Function() onCheckInClick;
  final void Function() onShareClick;
  final void Function() onMapsClick;

  const _EventOptionsBottomSheetState({
    Key? key,
    required this.onCheckInClick,
    required this.onShareClick,
    required this.onMapsClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void Function() decorateClick(void Function() fn) {
      return () {
        Navigator.pop(context);
        fn();
      };
    }

    return Wrap(
      children: [
        Column(
          children: [
            _EventOptionsButton.header(
              icon: Icons.beenhere,
              title: context.appString.eventOptionsCheckInAction,
              onClick: decorateClick(onCheckInClick),
            ),
            if (!kIsWeb)
              _EventOptionsButton(
                icon: Icons.share,
                title: context.appString.eventOptionsShareAction,
                onClick: decorateClick(onShareClick),
              ),
            _EventOptionsButton.footer(
              icon: Icons.location_on,
              title: context.appString.eventOptionsMapsAction,
              onClick: decorateClick(onMapsClick),
            ),
          ],
        )
      ],
    );
  }
}

class _EventOptionsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onClick;
  final bool asHeader; //addTopSpacer
  final bool asFooter; //addBottomSpacer

  const _EventOptionsButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  })  : asHeader = false,
        asFooter = false,
        super(key: key);

  const _EventOptionsButton.header({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  })  : asHeader = true,
        asFooter = false,
        super(key: key);

  const _EventOptionsButton.footer({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  })  : asHeader = false,
        asFooter = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final dimens = theme.dimens;
    final spacing = dimens.spacing;
    final topHeight = !asHeader ? spacing.normal : spacing.xxnormal;
    final bottomHeight = !asFooter ? spacing.normal : spacing.large;
    return AppHorizontalExpanded(
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: EdgeInsets.only(left: dimens.spacing.normal),
          child: Column(
            children: [
              SizedBox(height: topHeight),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  SizedBox(width: dimens.spacing.small),
                  Text(title)
                ],
              ),
              SizedBox(height: bottomHeight),
            ],
          ),
        ),
      ),
    );
  }
}
