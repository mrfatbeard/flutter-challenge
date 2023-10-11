import 'package:flutter/material.dart';
import 'package:flutter_challenge/themes/rounded_tab_bar_style.dart';

class RoundedTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final TextStyle? unselectedLabelStyle;
  final Color? unselectedLabelColor;
  final double? radius;
  final Function(int)? onTap;

  const RoundedTabBar({
    super.key,
    required this.tabs,
    this.tabController,
    this.backgroundColor,
    this.indicatorColor,
    this.labelStyle,
    this.labelColor,
    this.unselectedLabelStyle,
    this.unselectedLabelColor,
    this.radius,
    this.onTap,
  });

  static RoundedTabBar? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<RoundedTabBar>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.extension<RoundedTabBarStyle>()!;
    final containerRadius = radius ?? 20;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? style.unselectedTabColor,
        borderRadius: BorderRadius.circular(containerRadius),
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: labelStyle ?? style.selectedTextStyle,
        labelColor: labelColor ?? style.selectedTextStyle.color,
        unselectedLabelStyle: unselectedLabelStyle ?? style.unselectedTextStyle,
        unselectedLabelColor: unselectedLabelColor ?? style.unselectedTextStyle.color,
        controller: tabController,
        onTap: onTap,
        indicator: RoundedTabIndicator(
          radius: Radius.circular(containerRadius),
          color: indicatorColor ?? style.selectedTabColor,
        ),
        tabs: tabs,
      ),
    );
  }
}

class RoundedTabIndicator extends Decoration {
  final Radius radius;
  final Color color;

  @override
  final EdgeInsetsGeometry padding;

  const RoundedTabIndicator({
    required this.radius,
    required this.color,
    this.padding = EdgeInsets.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return RoundedIndicatorPainter(decoration: this, radius: radius, color: color, onChanged: onChanged);
  }
}

class RoundedIndicatorPainter extends BoxPainter {
  final Decoration decoration;
  final Radius radius;
  final Color color;
  final Paint indicatorPaint;

  RoundedIndicatorPainter({
    required this.decoration,
    required this.radius,
    required this.color,
    VoidCallback? onChanged,
  })  : indicatorPaint = Paint()
    ..color = color
    ..style = PaintingStyle.fill,
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var rRect = RRect.fromRectAndRadius(_rectForIndicator(offset, configuration), radius);
    canvas.drawRRect(
      rRect,
      indicatorPaint,
    );
  }

  Rect _rectForIndicator(Offset offset, ImageConfiguration configuration) {
    final size = configuration.size;
    if (size == null) return Rect.zero;

    final padding = decoration.padding;
    final insets = padding.resolve(configuration.textDirection);

    return Rect.fromLTWH(
      offset.dx + insets.left,
      offset.dy + insets.top,
      size.width - insets.left - insets.right,
      size.height - insets.top - insets.bottom,
    );
  }
}
