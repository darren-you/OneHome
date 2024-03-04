import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onehome/views/infrared/infrared_page_vm.dart';

import '../../components/appbar/normal_appbar.dart';
import '../../components/view/custom_body.dart';
import '../../components/view/setting_item.dart';
import '../../enumm/appbar_enum.dart';
import '../../enumm/color_enum.dart';

class InfraredPage extends GetView<InfraredPageViewModel> {
  const InfraredPage({super.key});

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
                      '热敏红外模块（Passive Infrared Sensor，简称PIR传感器）检测人体存在的原理基于人体及其他物体自然发射的红外辐射。人体由于其体温，会持续发射出特定波长的红外辐射。PIR传感器能够感知这种特定波长的红外辐射的变化。',
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
                  child: Obx(() => CupertinoSwitch(
                        value: controller.infraredLogicSwitch.value,
                        onChanged: (value) {
                          controller.setInfraredLogicSwitch(value);
                        },
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
