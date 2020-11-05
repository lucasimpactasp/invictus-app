import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerUtils {
  static showBanner(
    String title,
    String text, {
    Function onTap,
    Color backgroundColor,
    Color colorText,
    Icon icon,
    bool hasIcon = true,
  }) {
    if (backgroundColor == null) {
      backgroundColor = Colors.blueAccent;
    }

    if (colorText == null) {
      colorText = Colors.white;
    }

    if (icon == null && hasIcon) {
      icon = Icon(
        Icons.check,
        color: colorText,
      );
    }

    return Get.snackbar(
      title,
      text,
      colorText: colorText,
      icon: icon,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.all(24),
      onTap: onTap,
    );
  }

  static showErrorBanner(
    String text, {
    String title = 'Error',
    Color backgroundColor,
    Color colorText,
    Icon icon,
  }) {
    if (backgroundColor == null) {
      backgroundColor = Colors.redAccent;
    }

    if (colorText == null) {
      colorText = Colors.white;
    }

    if (icon == null) {
      icon = Icon(
        Icons.close,
        color: colorText,
      );
    }

    return Get.snackbar(
      title,
      text,
      colorText: colorText,
      icon: icon,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.all(24),
    );
  }

  static showAttentionBanner(
    String text, {
    String title = 'Aviso',
    Color backgroundColor,
    Color colorText,
    Icon icon,
  }) {
    if (backgroundColor == null) {
      backgroundColor = Colors.orange[300];
    }

    if (colorText == null) {
      colorText = Colors.white;
    }

    if (icon == null) {
      icon = Icon(
        Icons.warning,
        color: colorText,
      );
    }

    return Get.snackbar(
      title,
      text,
      colorText: colorText,
      icon: icon,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.all(24),
    );
  }
}
