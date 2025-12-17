import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceUtility {
  DeviceUtility._();

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  static bool isLandscapeOrientation(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static bool isPortraitOrientation(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double getPixelRatio(BuildContext context) =>
      MediaQuery.of(context).devicePixelRatio;

  static double getStatusBarHeight(BuildContext context) =>
      MediaQuery.paddingOf(context).top;

  static double getBottomNavigationBarHeight() => kBottomNavigationBarHeight;

  static double getAppBarHeight() => kToolbarHeight;

  static double getKeyboardHeight(BuildContext context) =>
      MediaQuery.viewInsetsOf(context).bottom;

  static Future<bool> isKeyboardVisible(BuildContext context) async =>
      MediaQuery.viewInsetsOf(context).bottom > 0;

  static Future<bool> isPhysicalDevice() async =>
      Platform.isAndroid || Platform.isIOS;

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, HapticFeedback.vibrate);
  }

  static Future setPreferredOrientations(
    List<DeviceOrientation> orientations,
  ) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  static bool isIOS() => Platform.isIOS;

  static bool isAndroid() => Platform.isAndroid;

  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static String getPlatform() => Platform.operatingSystem;
}
