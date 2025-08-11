import 'package:flutter/material.dart';
import '../../ds/theme/elevation.dart';
import '../../ds/theme/radius.dart';

class AppCard extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final Color? color;
  final List<BoxShadow> elevation;
  final BorderRadiusGeometry borderRadius;
  final BoxBorder? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.elevation = Elevation.level1,
    this.borderRadius = const BorderRadius.all(Radius.circular(Radii.r16)),
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? Theme.of(context).colorScheme.surface;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: effectiveColor,
        borderRadius: borderRadius,
        boxShadow: elevation,
        border: border,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

