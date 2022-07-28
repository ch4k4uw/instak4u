import 'package:core/common.dart';
import 'package:core/ui.dart';
import 'package:flutter/material.dart';

class FeedScreenListItem extends StatelessWidget {
  final String image;
  final String title;
  final double value;
  final void Function() onClick;
  static int index = -1;

  FeedScreenListItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.value,
      required this.onClick})
      : super(key: key) {
    ++index;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final dimens = context.appTheme.dimens;

    return Stack(
      children: [
        Card(
          child: Column(
            children: [
              Expanded(
                child: AppRemoteImage(url: image),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(dimens.spacing.tiny),
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.subtitle2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(dimens.spacing.tiny),
                    child: Text(
                      value.toPtBrCurrencyString(),
                      style: textTheme.subtitle1,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(onTap: onClick),
        )
      ],
    );
  }
}
