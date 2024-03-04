import 'package:flutter/material.dart';

import 'animated_notification.dart';
import 'animated_toast.dart';

class CustomNotification {
  static Map<String, OverlayEntry> overlayEntryMap = {};

  /// 顶部Notification, 可以设置不同的tag显示多个
  /// 可以用removeByTag关闭特定的noticfation实例
  static void notification(BuildContext context, String msg, {String? tag}) {
    // 移除所有的overlayEntry
    overlayEntryMap.removeWhere((key, overlayEntry) {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
        return true;
      }
      return false;
    });

    OverlayState overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => AnimatedNotification(
          context: context, overlayEntry: overlayEntry, msg: msg),
    );

    if (tag != null) {
      overlayEntryMap[tag] = overlayEntry;
    }
    overlayEntry.removeListener(() {
      if (tag != null) {
        overlayEntryMap.remove(tag);
      }
    });

    overlayState.insert(overlayEntry);
  }

  static void removeByTag(String tag) {
    OverlayEntry? overlayEntry = overlayEntryMap[tag];
    if (overlayEntry?.mounted ?? false) {
      overlayEntry?.remove();
    }
  }

  /// 同时只保证界面只有一个noticfation
  static OverlayEntry? _currentNotification;
  static void notice(BuildContext context, String msg) {
    OverlayState overlayState = Overlay.of(context);

    // 如果当前有正在显示的Notification，则移除它
    if (_currentNotification != null && _currentNotification!.mounted) {
      _currentNotification!.remove();
    }

    // 创建新的Notification
    _currentNotification = OverlayEntry(
      builder: (context) => AnimatedNotification(
          context: context, overlayEntry: _currentNotification, msg: msg),
    );

    // 显示新的Notification
    overlayState.insert(_currentNotification!);

    // 当Notification消失时，清除对它的引用
    _currentNotification!.addListener(() {
      if (!_currentNotification!.mounted) {
        _currentNotification = null;
      }
    });
  }

  /// 底部Toast
  static OverlayEntry? _currentToast;
  static void toast(BuildContext context, String msg) {
    OverlayState overlayState = Overlay.of(context);

    // 如果当前有正在显示的Toast，则移除它
    if (_currentToast != null && _currentToast!.mounted) {
      _currentToast!.remove();
    }

    // 创建新的Toast
    _currentToast = OverlayEntry(
      builder: (context) => AnimatedToast(
          context: context, overlayEntry: _currentToast, msg: msg),
    );

    // 显示新的Toast
    overlayState.insert(_currentToast!);
  }
}
