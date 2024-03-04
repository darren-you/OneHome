import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onehome/views/user/user_page.dart';

import '../../components/keep_alive_wrapper.dart';
import '../../utils/statebar_util.dart';
import '../machinepage/machine_page.dart';
import 'vo/nav_item.dart';

class NavPageViewModel extends GetxController {
  final operationalLog = StringBuffer();
  // ViewPageController默认选中第一页
  final pageController = PageController(initialPage: 0);
  // PagerView 中加载的页面
  final pagerList = [
    const KeepAliveWrapper(child: MachinePage()),
    const KeepAliveWrapper(child: UserPage()),
  ];
  // 底部导航栏 Item
  final List<Rx<BottomNavItem>> navItemsList =
      BottomNavItem.empty().buildNavItems();

  // 点击底部导航栏Item时，将对应的Item设为选中状态
  void selectBottomNavItem(Rx<BottomNavItem> currentItem) {
    // 让ViewPager滑动到选中页面
    pageController.animateToPage(
      navItemsList.indexOf(currentItem),
      duration: const Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
    );

    // 更改 ItemModel 状态
    for (var item in navItemsList) {
      item.update((oldItem) {
        oldItem?.isSelected = (item == currentItem);
      });
    }
  }

  @override
  void onReady() {
    super.onReady();

    StateBarUtil.setAndroidStateBarColor(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
  }
}
