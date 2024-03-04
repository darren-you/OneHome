import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onehome/views/radar/radar_page_vm.dart';

import '../../components/appbar/normal_appbar.dart';
import '../../components/view/custom_body.dart';
import '../../components/view/setting_item.dart';
import '../../enumm/appbar_enum.dart';
import '../../enumm/color_enum.dart';

class RadarPage extends GetView<RadarPageViewModel> {
  const RadarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      backgroundColor: MyColors.background.color,
      scroller: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      appBar: NormalAppBar(
        title: Text(
          controller.cardModel.value.dHome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: context.width,
        height: context.height -
            AppBarOptions.hight50.height -
            context.mediaQueryPadding.bottom -
            context.mediaQueryPadding.top,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Obx(
                () => Text(
                  controller.cardModel.value.data == '1' ? '有人' : '无人',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Text(
              '是否存在人体',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(12)),
              child: RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  text:
                      '雷达模块通过分析返回波的频率变化来检测是否有物体在移动，从而判断人体是否存在。这种检测方式非常灵敏，即使是微小的运动，如呼吸或心跳引起的胸部微小运动，也能被高灵敏度的雷达模块捕捉到。',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SettingItem(
              body: [
                const Positioned(
                  left: 16,
                  child: Row(
                    children: [
                      Text(
                        "有人时开启台灯",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  child: Obx(
                    () => CupertinoSwitch(
                      value: controller.ladarLogicSwitch.value,
                      onChanged: (value) {
                        controller.setLadarLogicSwitch(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
