import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onehome/views/humidity/humidity_page_vm.dart';

import '../../components/appbar/normal_appbar.dart';
import '../../components/view/custom_body.dart';
import '../../components/view/setting_item.dart';
import '../../enumm/appbar_enum.dart';
import '../../enumm/color_enum.dart';

class HumidityPage extends GetView<HumidityPageViewModel> {
  const HumidityPage({super.key});

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
                  '${controller.cardModel.value.data}%',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Text(
              '当前湿度',
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
                      '人体舒适的相对湿度通常认为是在40%到60%之间。在这个湿度范围内，大多数人会感觉比较舒适，且对健康有益。如果相对湿度太低，人们可能会感到皮肤干燥、呼吸道不适；而相对湿度过高，则可能导致身体散热困难，感觉闷热，同时也可能促进细菌和霉菌的生长，对健康不利。',
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
                        "低于30%时开启加湿器",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (value) {},
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
