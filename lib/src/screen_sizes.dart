import 'package:flutter/material.dart';

enum ScreenSize {
  mobile(600),
  tablet(900),
  desktop(1200);

  final double width;
  const ScreenSize(this.width);

  static ScreenSize current(double width) {
    if (width < ScreenSize.mobile.width) {
      return ScreenSize.mobile;
    } else if (width < ScreenSize.tablet.width) {
      return ScreenSize.tablet;
    } else {
      return ScreenSize.desktop;
    }
  }
}

extension ScreenSizeExtension on ScreenSize {
  bool isMobile(BuildContext context) => context.isMobile;
  bool isTablet(BuildContext context) => context.isTablet;
  bool isDesktop(BuildContext context) => context.isDesktop;
}

extension Query on BuildContext {
  // MediaQueryData
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;

  bool get isMobile => width < ScreenSize.mobile.width;
  bool get isTablet => width < ScreenSize.tablet.width;
  bool get isDesktop => width > ScreenSize.desktop.width;
}
