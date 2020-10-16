import 'package:flutter/material.dart';
import 'package:invictus/core/models/widgets/responsive/responsive.model.dart';

class ResponsiveUtils {
  static final int mobileSize = 260;
  static final int tabletPortraitSize = 480;
  static final int tabletLandscapeSize = 720;
  static final int desktopSize = 1200;
  static final int stableSize = 1200;

  static DeviceScreenType getDeviceScreenType(Size size) {
    if (size.width < tabletPortraitSize) {
      return DeviceScreenType.Mobile;
    } else if (size.width >= tabletPortraitSize &&
        size.width < tabletLandscapeSize) {
      return DeviceScreenType.TabletPortrait;
    } else if (size.width >= tabletLandscapeSize && size.width < desktopSize) {
      return DeviceScreenType.Desktop;
    } else {
      return DeviceScreenType.Stable;
    }
  }
}
