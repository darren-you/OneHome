import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:onehome/views/mainpage/nav_page_vm.dart';

import '../../enumm/color_enum.dart';
import '../../enumm/nav_enum.dart';
import 'vo/nav_item.dart';

class NavPage extends GetView<NavPageViewModel> {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        // fix 此处使用padding.bottom 会造成iOS在App预览Card状态时，底部无内容
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        color: Colors.white,
        child: Stack(
          children: [
            // https://juejin.cn/post/6844903791972581390#comment 保存页面状态
            // ViewPager
            Align(
              alignment: Alignment.topCenter,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(), // 禁止滑动
                controller: controller.pageController,
                children: controller.pagerList,
              ),
            ),

            // 底部导航栏
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: context.width,
                height: NavigationOptions.hight55.height,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.navItemsList.map((item) {
                    return navItem(item);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 底部导航栏Item
Widget navItem(Rx<BottomNavItem> item) {
  final controller = Get.find<NavPageViewModel>();
  return Expanded(
    child: GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        controller.selectBottomNavItem(item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => SvgPicture.asset(
                item.value.assertIcon,
                width: 30,
                height: 30,
                colorFilter: item.value.isSelected
                    ? ColorFilter.mode(MyColors.iconBlue.color, BlendMode.srcIn)
                    : null,
              ),
            ),
            Obx(() => Text(
                  item.value.text,
                  style: TextStyle(
                      color: item.value.isSelected
                          ? MyColors.iconBlue.color
                          : MyColors.iconGrey1.color,
                      fontSize: 12),
                )),
          ],
        ),
      ),
    ),
  );
}
