import 'package:flutter/widgets.dart';

class Breakpoints {
  static const double phoneSmall = 320;
  static const double phone = 375;
  static const double phoneLarge = 430;
  static const double tablet = 768;
  static const double desktop = 1024;
}

extension MediaQueryX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
}

class Responsive {
  final double width;
  Responsive(this.width);

  factory Responsive.of(BuildContext context) => Responsive(context.screenWidth);

  bool get isPhoneSmall => width < Breakpoints.phone;
  bool get isPhone => width >= Breakpoints.phone && width < Breakpoints.tablet;
  bool get isTablet => width >= Breakpoints.tablet && width < Breakpoints.desktop;
  bool get isDesktop => width >= Breakpoints.desktop;

  int get gridColumns {
    if (isDesktop) return 4;
    if (isTablet) return 3;
    return 2;
  }
}

