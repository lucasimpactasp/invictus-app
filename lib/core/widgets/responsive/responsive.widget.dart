import 'package:flutter/material.dart';
import 'package:invictus/core/models/widgets/responsive/responsive.model.dart';
import 'package:invictus/utils/responsive/responsive.utils.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobile;
  final Widget tabletPortrait;
  final Widget tabletLandscape;
  final Widget desktop;
  final Widget stable;

  ResponsiveLayout(
      {this.mobile,
      this.tabletPortrait,
      this.tabletLandscape,
      this.desktop,
      this.stable});

  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  DeviceScreenType deviceScreenType;
  bool alreadyGeneratedOrientation = false;

  @override
  void initState() {
    super.initState();
  }

  void getDeviceScreenType(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width <= ResponsiveUtils.untilMobileSize) {
      setState(() => deviceScreenType = DeviceScreenType.Mobile);
    } else if (screenSize.width > ResponsiveUtils.untilMobileSize &&
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
    }
  }

  Widget generateContent() {
    switch (deviceScreenType) {
      case DeviceScreenType.Mobile:
        return widget.mobile;
      case DeviceScreenType.TabletPortrait:
        return widget.tabletPortrait;
      case DeviceScreenType.TabletLandscape:
        return widget.tabletLandscape;
      case DeviceScreenType.Desktop:
        return widget.desktop;
      case DeviceScreenType.Stable:
        return widget.stable;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!alreadyGeneratedOrientation) {
      getDeviceScreenType(context);
    }
    
    return Column(
      children: [
        generateContent(),
      ],
    );
  }
}
