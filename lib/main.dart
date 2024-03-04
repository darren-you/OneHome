import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'rountes/app_rountes.dart';
import 'service/init_service.dart';
import 'utils/page_path_util.dart';

void main() async {
  // flutter build apk --target-platform=android-arm64
  // 全局初始化
  await InitService.init();
  runApp(const OneHomeApp());
}

class OneHomeApp extends StatelessWidget {
  const OneHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FlutterSmartDialog.init(),
      initialRoute: PagePathUtil.mainNavigationPage,
      getPages: AppRountes.appRoutes,
      theme: ThemeData(platform: TargetPlatform.iOS),
    );
  }
}
