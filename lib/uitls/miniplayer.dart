import 'dart:ui';

import 'package:window_manager/window_manager.dart';

miniplayer(bool isFullScreen) async {
  if (!isFullScreen) {
    await windowManager.setSize(const Size(500, 100), animate: true);
  }
}

docked(bool isFullScreen) async {
  if (!isFullScreen) {
    await windowManager.setSize(const Size(500, 10), animate: true);
  }
}

playlist(bool isFullScreen) async {
  if (!isFullScreen) {
    await windowManager.setSize(const Size(500, 350), animate: true);
  }
}
