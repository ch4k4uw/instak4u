import 'package:core/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class EventDetailsScreenEventDetails extends StatelessWidget {
  final Widget? image;
  final String title;
  final String description;

  const EventDetailsScreenEventDetails({
    Key? key,
    this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final dimens = theme.dimens;
    final textTheme = theme.textTheme;
    final image = this.image;

    Widget content() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: dimens.spacing.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: dimens.spacing.normal),
            Text(
              title,
              style: textTheme.headline6,
            ),
            SizedBox(height: dimens.spacing.xtiny),
            Padding(
              padding: EdgeInsets.only(bottom: dimens.spacing.xxnormal),
              child: Text(
                description,
                style: textTheme.subtitle1,
              ),
            ),
          ],
        ),
      );
    }

    if (image != null) {
      return Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 4,
            child: Column(children: [image, content()]),
          ),
          SizedBox(height: dimens.spacing.xxnormal)
        ],
      );
    }

    return _SliverFillViewPortBoxAdapter(
      child: content(),
    );
  }
}

class _SliverFillViewPortBoxAdapter extends SingleChildRenderObjectWidget {
  const _SliverFillViewPortBoxAdapter({
    super.child,
  });

  @override
  _RenderFillViewPortBoxAdapter createRenderObject(BuildContext context) =>
      _RenderFillViewPortBoxAdapter();
}

class _RenderFillViewPortBoxAdapter extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final double viewPortHeight = constraints.viewportMainAxisExtent;
    final double childExtent = math.max(child!.size.height, viewPortHeight);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);
  }
}
