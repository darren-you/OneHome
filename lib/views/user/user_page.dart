import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:onehome/utils/page_path_util.dart';
import '../../components/view/setting_item_text.dart';
import '../../enumm/color_enum.dart';
import '../../utils/assert_util.dart';
import 'user_page_vm.dart';

/// 用户背景图片
Widget _userBg(BuildContext context, UserPageViewModel controller) {
  return Obx(
    // Transform.translate offset实现背景图部分，与ListView同时发生移动
    () => Transform.translate(
      offset: Offset(
          0, controller.offset.value < 0 ? 0 : -(controller.offset.value)),
      child: Container(
        color: Colors.transparent,
        height: context.height / 2.9,
        child: Obx(
          () => Transform.scale(
            scale: controller.userBgPicScale.value,
            child: Stack(
              children: [
                SizedBox(
                  height: context.height / 2.91,
                  child: ExtendedImage.network(
                    "https://singlestep.cn/wejinda/res/img/onestep_bg.jpeg",
                    fit: BoxFit.cover,
                    cache: true,
                    //cancelToken: cancellationToken,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0, 1),
                      end: const Alignment(0, -0.2),
                      colors: [
                        //Colors.blue,
                        MyColors.background.color,
                        MyColors.background.color.withOpacity(0.6),
                        MyColors.background.color.withOpacity(0.0),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _userLogined(BuildContext context, UserPageViewModel controller) {
  return Container(
    //color: Colors.amber,
    height: context.height / 3.2,
    child: Column(
      children: [
        // 头像、性别、专业
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            height: 60,
            child: Row(
              children: [
                // 头像
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                    child: ExtendedImage.network(
                      "https://singlestep.cn/wejinda/res/img/onestep_avater.jpeg",
                      fit: BoxFit.contain,
                      //mode: ExtendedImageMode.editor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 信息部分
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "OneStep",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //const SizedBox(height: 12),
                        Row(
                          children: [
                            // 性别
                            SvgPicture.asset(
                              AssertUtil.manSvg,
                              width: 26,
                              height: 26,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            // 专业
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: MyColors.cardGreen.color,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                '软件工程',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  child: SvgPicture.asset(
                    AssertUtil.iconGo,
                    width: 12,
                    height: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            //color: Colors.amber,
            child: const Text(
              'Coding for future, 写完这行就出发！\n 骑行🚴、羽毛球🏸、摄影📷...',
              maxLines: 2,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class UserPage extends GetView<UserPageViewModel> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'screen height: ${context.mediaQuery.size.height} status height: ${context.mediaQueryPadding.top} bottom height: ${context.mediaQueryPadding.bottom}');
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: Stack(
        children: [
          // 底层，用户渐变背景图片
          _userBg(context, controller),

          // 用户信息，功能部分
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(), // 这里设置滚动物理属性
                children: [
                  // 用户信息
                  _userLogined(context, controller),

                  // 功能Item部分
                  // Container(
                  //   height: 80,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),

                  // 软件设置部分
                  SettingItemText(
                    borderRadius: BorderRadius.circular(10),
                    text: "操作日志",
                    onTap: () {
                      Get.toNamed(PagePathUtil.operationalLogPage);
                      debugPrint("点击 ");
                    },
                  ),
                  const SizedBox(height: 12),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      //color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SettingItemText(
                          text: "开启语音(beta)",
                          onTap: () {},
                        ),
                        SettingItemText(
                          text: "软件升级",
                          onTap: () {
                            Get.toNamed(PagePathUtil.appUpdatePage);
                            debugPrint("点击 软件升级");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
