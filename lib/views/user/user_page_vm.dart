import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPageViewModel extends GetxController {
  ScrollController scrollController = ScrollController();
  var offset = 0.0.obs;
  var userBgPicScale = 1.0.obs; // 图片放大倍数

  void _setScale(double offset) {
    if (offset < 0) {
      final scale = 1 + offset.abs() / 300;
      //userBgPicScale.value = scale.clamp(1, 1.3).toDouble();
      userBgPicScale.value = scale.clamp(1, 3).toDouble();
      // debugPrint('放大倍数: ${userBgPicScale.value}');
    }
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(() {
      offset.value = scrollController.offset;
      debugPrint('offset: > > > ${offset.value}}');
      _setScale(offset.value);
      // debugPrint('滑动偏差: ${offset.value}');
    });
  }
}
