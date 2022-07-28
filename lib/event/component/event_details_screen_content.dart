import 'dart:math' as math;
import 'dart:ui';

import 'package:core/common.dart';
import 'package:core/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instak4u/common/extensions/build_context_extensions.dart';
import 'package:instak4u/common/profile_bottom_sheet.dart';
import 'package:instak4u/event/component/event_component_constants.dart';
import 'package:instak4u/event/component/event_details_screen_event_details.dart';
import 'package:instak4u/event/event_options_bottom_sheet.dart';
import 'package:presenter/common.dart';

class EventDetailsScreenContent extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final UserView userView;
  final void Function()? onLogout;
  final void Function()? onNavigateBack;
  final void Function()? onShare;
  final void Function()? onPerformCheckIn;
  final void Function()? onShowMap;

  const EventDetailsScreenContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.userView,
    this.onLogout,
    this.onNavigateBack,
    this.onShare,
    this.onPerformCheckIn,
    this.onShowMap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventDetailsScreenContentState();
}

class _EventDetailsScreenContentState extends State<EventDetailsScreenContent> {
  final ScrollController largeController = ScrollController();
  final ScrollController normalController = ScrollController();
  final _NormalTransition normalTransition = _NormalTransition();
  late double expandedHeight;
  bool isLargeToolbarOpaque = false;
  bool isLargeToolbarVisible = false;

  @override
  Widget build(BuildContext context) {
    final isLarge = context.screenInfo.width.isLarge;
    expandedHeight = context.screenInfo.height *
        EventComponentConstants.topBarHScreenFraction;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isLarge
          ? _LargeScreen(
              key: const PageStorageKey(1),
              parent: widget,
              onShowProfile: () => _showProfileDialog(context: context),
              onToolbarAnimationEnd: () {
                if (!isLargeToolbarOpaque) {
                  isLargeToolbarVisible = false;
                }
              },
              largeController: largeController,
              expandedHeight: expandedHeight,
              isLargeToolbarOpaque: isLargeToolbarOpaque,
              isLargeToolbarVisible: isLargeToolbarVisible,
            )
          : _NormalScreen(
              key: const PageStorageKey(2),
              parent: widget,
              onShowProfile: () => _showProfileDialog(context: context),
              normalController: normalController,
              expandedHeight: expandedHeight,
              normalTransition: normalTransition,
            ),
    );
  }

  void _showProfileDialog({required BuildContext context}) {
    context.showProfileBottomSheet(
      name: widget.userView.name,
      email: widget.userView.email,
      onLogoutClick: _performLogout,
    );
  }

  void _performLogout() {
    widget.onLogout?.call();
  }

  @override
  void initState() {
    super.initState();
    largeController.addListener(() {
      setState(() {
        isLargeToolbarOpaque = largeController.offset > kToolbarHeight;
        isLargeToolbarVisible |= isLargeToolbarOpaque;
      });
    });
    normalController.addListener(() {
      setState(() {
        const constants = EventComponentConstants.transitions;
        final transition = normalController.offset / expandedHeight;
        normalTransition.also((it) {
          it.topTransition = 1 - transition;
          it.transformTransition = 1 -
              constants.lerpTransformation(
                transition: transition,
              );
          it.alphaTransition = 1 - constants.lerpAlpha(transition: transition);
          it.titleTransition = 1 - constants.lerpTitle(transition: transition);
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    largeController.dispose();
    normalController.dispose();
  }
}

class _LargeScreen extends StatelessWidget {
  final EventDetailsScreenContent parent;
  final void Function() onShowProfile;
  final void Function() onToolbarAnimationEnd;
  final ScrollController largeController;
  final double expandedHeight;
  final bool isLargeToolbarOpaque;
  final bool isLargeToolbarVisible;

  const _LargeScreen({
    Key? key,
    required this.parent,
    required this.onShowProfile,
    required this.onToolbarAnimationEnd,
    required this.largeController,
    required this.expandedHeight,
    required this.isLargeToolbarOpaque,
    required this.isLargeToolbarVisible,
  }) : super(key: key);

  String get image => parent.image;

  String get title => parent.title;

  String get description => parent.description;

  UserView get userView => parent.userView;

  void Function()? get onLogout => parent.onLogout;

  void Function()? get onNavigateBack => parent.onNavigateBack;

  void Function()? get onShare => parent.onShare;

  void Function()? get onPerformCheckIn => parent.onPerformCheckIn;

  void Function()? get onShowMap => parent.onShowMap;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    return Stack(
      key: const ValueKey(1),
      children: [
        LayoutBuilder(
          builder: (_, constraints) {
            final topHeight =
                EventComponentConstants.largeScreenDetailsContentTopWeight *
                    constraints.maxHeight;
            const horizontalWeight = EventComponentConstants
                .largeScreenDetailsContentHorizontalWeight;
            final horizontalWidth = horizontalWeight * constraints.maxWidth;
            final middleWidth =
                EventComponentConstants.largeScreenDetailsContentMiddleWeight *
                    constraints.maxWidth;
            const coverImageHeightFraction = EventComponentConstants
                .largeScreenDetailsCoverImageHeightFraction;
            return SingleChildScrollView(
              controller: largeController,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Column(
                    children: [
                      _buildAppBar(context: context),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: topHeight),
                      Row(
                        children: [
                          SizedBox(width: horizontalWidth),
                          SizedBox(
                            width: middleWidth,
                            child: EventDetailsScreenEventDetails(
                              image: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: constraints.maxHeight,
                                ),
                                child: FractionallySizedBox(
                                  heightFactor: coverImageHeightFraction,
                                  child: AppRemoteImage(url: image),
                                ),
                              ),
                              title: title,
                              description: description,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        AnimatedOpacity(
          opacity: isLargeToolbarOpaque ? 1 : 0,
          onEnd: onToolbarAnimationEnd,
          duration: const Duration(milliseconds: 500),
          child: Column(
            children: [
              Visibility(
                visible: isLargeToolbarVisible,
                child: _buildAppBar(context: context, expanded: false),
              ),
            ],
          ),
        ),
        CustomSingleChildLayout(
          delegate: _FABLayoutDelegate.fixed(
            marginEnd: context.appTheme.dimens.spacing.normal,
          ),
          child: FloatingActionButton(
            tooltip: context.appString.eventOptionsCheckInAction,
            onPressed: () => onPerformCheckIn?.call(),
            child: const Icon(Icons.beenhere),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar({required BuildContext context, bool expanded = true}) {
    Widget buildTitle({bool isStyled = false}) {
      return Text(title, overflow: TextOverflow.ellipsis);
    }

    final leading = IconButton(
      onPressed: () => onNavigateBack?.call(),
      icon: const Icon(Icons.arrow_back),
    );

    Widget decorateAppBarWidget(Widget action) {
      if (!expanded) {
        return action;
      }
      return Column(
        children: [SizedBox(height: kToolbarHeight, child: action)],
      );
    }

    return AppBar(
      leading: decorateAppBarWidget(leading),
      title: expanded
          ? SizedBox(
              height: expandedHeight,
              child: decorateAppBarWidget(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [buildTitle()],
                ),
              ),
            )
          : buildTitle(),
      actions: [
        IconButton(
          onPressed: () => onShowMap?.call(),
          icon: const Icon(Icons.location_on),
          tooltip: context.appString.eventOptionsMapsAction,
        ),
        IconButton(
          onPressed: onShowProfile,
          icon: const Icon(Icons.person),
        )
      ].map(decorateAppBarWidget).toList(),
      toolbarHeight: expanded ? expandedHeight : null,
      elevation: expanded ? 0 : null,
    );
  }
}

class _NormalScreen extends StatelessWidget {
  final EventDetailsScreenContent parent;
  final ScrollController normalController;
  final _NormalTransition normalTransition;
  final double expandedHeight;
  final void Function() onShowProfile;

  const _NormalScreen({
    Key? key,
    required this.parent,
    required this.onShowProfile,
    required this.normalController,
    required this.expandedHeight,
    required this.normalTransition,
  }) : super(key: key);

  String get image => parent.image;

  String get title => parent.title;

  String get description => parent.description;

  UserView get userView => parent.userView;

  void Function()? get onLogout => parent.onLogout;

  void Function()? get onNavigateBack => parent.onNavigateBack;

  void Function()? get onShare => parent.onShare;

  void Function()? get onPerformCheckIn => parent.onPerformCheckIn;

  void Function()? get onShowMap => parent.onShowMap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final colorScheme = theme.data.colorScheme;
    final brightness = colorScheme.brightness;
    final isDark = brightness == Brightness.dark;
    final startText = context.appTheme.textTheme.headline5?.copyWith(
      color: isDark ? colorScheme.onSurface : colorScheme.onPrimary,
    );
    final endText = context.appTheme.textTheme.headline6?.copyWith(
      color: isDark ? colorScheme.onSurface : colorScheme.onPrimary,
    );

    Widget buildTitle({bool isStyled = false}) {
      return Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: isStyled
            ? TextStyle.lerp(
                endText,
                startText,
                normalTransition.titleTransition,
              )
            : null,
      );
    }

    return Stack(
      key: const ValueKey(2),
      children: [
        CustomScrollView(
          controller: normalController,
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: IconButton(
                onPressed: () => onNavigateBack?.call(),
                icon: const Icon(Icons.arrow_back),
              ),
              title: Opacity(
                opacity: 1 - normalTransition.titleTransition,
                child: buildTitle(),
              ),
              actions: [
                IconButton(
                  onPressed: onShowProfile,
                  icon: const Icon(Icons.person),
                ),
                IconButton(
                  onPressed: () => _showEventOptionsDialog(
                    context: context,
                    onCheckInClick: () => onPerformCheckIn?.call(),
                    onShareClick: () => onShare?.call(),
                    onMapsClick: () => onShowMap?.call(),
                  ),
                  icon: const Icon(Icons.more_vert),
                ),
              ],
              expandedHeight: expandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                title: Opacity(
                  opacity: normalTransition.titleTransition,
                  child: buildTitle(isStyled: true),
                ),
                background: AppRemoteImage(url: image),
              ),
            ),
            EventDetailsScreenEventDetails(
              title: title,
              description: description,
            ),
          ],
        ),
        CustomSingleChildLayout(
          delegate: _FABLayoutDelegate(
            expandedHeight: expandedHeight,
            topTransition: normalTransition.topTransition,
            marginEnd: context.appTheme.dimens.spacing.normal,
          ),
          child: normalTransition.let(
            (it) {
              final transition = it.transformTransition;
              const icon = kIsWeb ? Icons.beenhere : Icons.share;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(transition)
                  ..rotateZ(-lerpDouble(360, 0, transition)! * math.pi / 180),
                child: Opacity(
                  opacity: it.alphaTransition,
                  child: FloatingActionButton(
                    tooltip: context.appString.eventOptionsShareAction,
                    onPressed: () {
                      if (kIsWeb) {
                        onPerformCheckIn?.call();
                      } else {
                        onShare?.call();
                      }
                    },
                    child: const Icon(icon),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showEventOptionsDialog({
    required BuildContext context,
    required void Function() onCheckInClick,
    required void Function() onShareClick,
    required void Function() onMapsClick,
  }) {
    context.showEventOptionsBottomSheet(
      onCheckInClick: onCheckInClick,
      onShareClick: onShareClick,
      onMapsClick: onMapsClick,
    );
  }
}

class _NormalTransition {
  double topTransition = 1.0;
  double transformTransition = 1.0;
  double alphaTransition = 1.0;
  double titleTransition = 1.0;
}

class _FABLayoutDelegate extends SingleChildLayoutDelegate {
  final double expandedHeight;
  final double topTransition;
  final double marginEnd;
  final bool isFixed;

  _FABLayoutDelegate({
    required this.expandedHeight,
    required this.topTransition,
    required this.marginEnd,
  }) : isFixed = false;

  _FABLayoutDelegate.fixed({required this.marginEnd})
      : expandedHeight = 0,
        topTransition = 0,
        isFixed = true;

  @override
  bool shouldRelayout(_FABLayoutDelegate oldDelegate) {
    bool isEq = expandedHeight == oldDelegate.expandedHeight;
    isEq = isEq && topTransition == oldDelegate.topTransition;
    isEq = isEq && marginEnd == oldDelegate.marginEnd;
    isEq = isEq && isFixed == oldDelegate.isFixed;
    return !isEq;
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    if (!isFixed) {
      final halfHeight = childSize.height / 2;
      final y = -halfHeight + expandedHeight * topTransition;
      final x = -marginEnd - childSize.width + size.width;
      return Offset(x, y.clamp(0, expandedHeight - halfHeight));
    }
    return Offset(
      -marginEnd - childSize.width + size.width,
      -marginEnd - childSize.height + size.height,
    );
  }
}
