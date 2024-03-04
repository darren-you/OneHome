import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/assert_util.dart';

// 底部导航栏 Item
class BottomNavItem {
  String text = '';
  String assertIcon = '';
  VoidCallback onPressed = () {};
  bool isSelected = false;

  BottomNavItem.empty();

  BottomNavItem(this.text, this.assertIcon, this.onPressed,
      {this.isSelected = false});

  /// 返回底部导航栏 Item 项
  List<Rx<BottomNavItem>> buildNavItems() {
    List<Rx<BottomNavItem>> navItems = [];
    navItems.add(
        BottomNavItem("设备", AssertUtil.iconCourse, () {}, isSelected: true)
            .obs);
    navItems.add(BottomNavItem("我的", AssertUtil.iconMy, () {}).obs);

    return navItems;
  }
}
