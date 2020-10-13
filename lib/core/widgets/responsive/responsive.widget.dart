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

  void getDeviceScreenType(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    /* if (screenSize.width <= ResponsiveUtils.mobileSize) {
      setState(() => deviceScreenType = DeviceScreenType.Mobile);
    } else if (screenSize.width > ResponsiveUtils.mobileSize &&
        screenSize.width <= ResponsiveUtils.fromTabletPortraitSize) {
      setState(() => deviceScreenType = DeviceScreenType.TabletPortrait);
    } else if (screenSize.width > ResponsiveUtils.fromTabletPortraitSize &&
        screenSize.width <= ResponsiveUtils.fromTabletLandscapeSize) {
      setState(() => deviceScreenType = DeviceScreenType.TabletLandscape);
    } else if (screenSize.width > ResponsiveUtils.fromTabletLandscapeSize &&
        screenSize.width <= ResponsiveUtils.untilDesktopSize) {
      setState(() => deviceScreenType = DeviceScreenType.Desktop);
    } else {
      setState(() => deviceScreenType = DeviceScreenType.Stable);
    } */
  }

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
