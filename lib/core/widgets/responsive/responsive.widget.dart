import 'package:flutter/material.dart';
import 'package:invictus/utils/responsive/responsive.utils.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tabletPortrait;
  final Widget tabletLandscape;
  final Widget desktop;
  final Widget stable;

  ResponsiveLayout({
    @required this.mobile,
    @required this.desktop,
    this.tabletPortrait,
    this.tabletLandscape,
    this.stable,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > ResponsiveUtils.stableSize) {
          return stable ?? desktop;
        } else if (constraints.maxWidth > ResponsiveUtils.tabletLandscapeSize &&
            constraints.maxWidth <= ResponsiveUtils.desktopSize) {
          return desktop;
        } else if (constraints.maxWidth > ResponsiveUtils.tabletPortraitSize &&
            constraints.maxWidth <= ResponsiveUtils.tabletLandscapeSize) {
          return tabletLandscape ?? desktop;
        } else if (constraints.maxWidth > ResponsiveUtils.mobileSize &&
            constraints.maxWidth <= ResponsiveUtils.tabletPortraitSize) {
          return tabletPortrait ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
