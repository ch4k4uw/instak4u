import 'package:core/common/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';
import 'package:instak4u/common/profile_bottom_sheet.dart';
import 'package:instak4u/feed/component/feed_list_item.dart';
import 'package:presenter/common.dart';
import 'package:presenter/feed.dart';

class FeedScreenContent extends StatelessWidget {
  final List<EventHeadView> events;
  final UserView userView;
  final void Function(String)? onFindEventDetails;
  final void Function()? onLogout;
  final void Function()? onNavigateBack;

  const FeedScreenContent({
    Key? key,
    required this.events,
    required this.userView,
    this.onFindEventDetails,
    this.onLogout,
    this.onNavigateBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isLargeScreen = constraints.maxWidth >= 600;
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(
              onPressed: () => onNavigateBack?.call(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(context.appString.appName),
            actions: [
              IconButton(
                onPressed: () =>
                    context.showProfileBottomSheet(
                      name: userView.name,
                      email: userView.email,
                      onLogoutClick: () => onLogout?.call(),
                    ),
                icon: const Icon(Icons.person),
              )
            ],
          ),
          _buildResponsiveScreenList(events: events, large: isLargeScreen)
        ],
      );
    });
  }

  Widget _buildResponsiveScreenList({
    required List<EventHeadView> events,
    required bool large,
  }) {
    Widget container(Widget Function() child) {
      return large
          ? _LargeScreenListItemContainer(child: child())
          : _ScreenListItemContainer(child: child());
    }

    final delegate = SliverChildBuilderDelegate(
      childCount: events.length,
          (BuildContext context, int index) {
        final event = events[index];
        return container(
              () =>
              FeedScreenListItem(
                image: event.image,
                title: event.title,
                value: event.price,
                onClick: () => onFindEventDetails?.call(event.id),
              ),
        );
      },
    );

    return large
        ? SliverFillViewport(delegate: delegate)
        : SliverList(delegate: delegate);
  }
}

class _LargeScreenListItemContainer extends StatelessWidget {
  final Widget child;

  const _LargeScreenListItemContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = context.appTheme.dimens;
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: child,
            ),
          ),
          SizedBox(height: dimens.spacing.xtiny)
        ],
      ),
    );
  }
}

class _ScreenListItemContainer extends StatelessWidget {
  final Widget child;

  const _ScreenListItemContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = context.appTheme.dimens;
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: [
          Expanded(
            child: child,
          ),
          SizedBox(height: dimens.spacing.xtiny)
        ],
      ),
    );
  }
}