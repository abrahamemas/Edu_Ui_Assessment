import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class Responsive {
  static double horizontalPadding(BoxConstraints constraints) {
    final double w = constraints.maxWidth;
    if (w < 360) return 12;
    if (w < 400) return 16;
    if (w < 480) return 24;
    return 32;
  }

  static double scaleForWidth(BoxConstraints constraints, {double min = 0.9, double max = 1.15}) {
    final double w = constraints.maxWidth;
    final double base = 390; // iPhone 12 logical width reference
    final double s = w / base;
    return s.clamp(min, max);
  }

  static double clampHeight(BuildContext context, {required double fraction, required double min, required double max}) {
    final double h = MediaQuery.of(context).size.height * fraction;
    return math.max(min, math.min(max, h));
  }
}




