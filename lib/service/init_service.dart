import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'mqtt_service.dart';

class InitService {
  static Future<void> init() async {
    debugPrint('< < <   全局初始化 start...   > > >');
    // 初始化 WidgetsFlutterBinding
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化窗口管理
    // if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    //   await windowManager.ensureInitialized();
    //   WindowOptions windowOptions = const WindowOptions(
    //       size: Size(1000, 680),
    //       center: true,
    //       backgroundColor: Colors.transparent,
    //       skipTaskbar: false,
    //       titleBarStyle: TitleBarStyle.hidden,
    //       minimumSize: Size(1000, 680));
    //   windowManager.waitUntilReadyToShow(windowOptions, () async {
    //     await windowManager.show();
    //     await windowManager.focus();
    //   });
    //   debugPrint('< < <   窗口初始化完成✅   > > >');
    // }

    Get.put(MqttService());

    debugPrint('< < <   全局初始化 end...   > > >');
  }
}
