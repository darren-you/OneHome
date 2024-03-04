import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onehome/components/appbar/normal_appbar.dart';
import 'package:onehome/components/view/custom_body.dart';
import 'package:onehome/enumm/appbar_enum.dart';
import 'package:onehome/enumm/color_enum.dart';
import 'package:onehome/views/temperature/temperature_page_vm.dart';

import '../../components/view/setting_item.dart';

class TemperaturePage extends GetView<TemperaturePageViewModel> {
  const TemperaturePage({super.key});

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
                  '${controller.cardModel.value.data}°C',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Text(
              '当前温度',
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
                      '一般来说，大多数人在室内环境中感到舒适的温度范围大约是在18°C到24°C（64°F到75°F）之间。然而，这个范围可能会根据上述因素以及个人差异而有所不同',
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
                        "高于26°C时开启空调",
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
