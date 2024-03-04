import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onehome/components/appbar/normal_appbar.dart';
import 'package:onehome/components/container/custom_container.dart';
import 'package:onehome/components/view/custom_body.dart';
import 'package:onehome/enumm/appbar_enum.dart';
import 'package:onehome/enumm/color_enum.dart';
import 'package:onehome/views/light/light_page_vm.dart';

class LightPage extends GetView<LightPageViewModel> {
  const LightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        enableAppBarPadding: false,
        padding: EdgeInsets.only(
            top: AppBarOptions.hight50.height + context.mediaQueryPadding.top),
        appBar: const NormalAppBar(
          title: Text(
            '台灯',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          color: Colors.white,
        ),
        body: Stack(
          children: [
            Container(
              width: context.width,
              height: context.height -
                  AppBarOptions.hight50.height -
                  context.mediaQueryPadding.top,
              color: MyColors.background.color,
              child: Center(
                child: Obx(() => Text(
                      '台灯亮度: % ${controller.sliderValue.value.toInt()}',
                      style: const TextStyle(fontSize: 16),
                    )),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(left: 16, bottom: 32, right: 16),
                width: context.width,
                height: 200,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35)),
                      child: Obx(
                        () => Slider(
                          value: controller.sliderValue.value,
                          onChanged: (value) {
                            controller.sliderValue.value = value;
                          },
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: '${controller.sliderValue.value.toInt()}',
                          activeColor: Colors.blue, // 激活部分的轨道颜色
                          inactiveColor: Colors.grey, // 未激活轨道部分的颜色
                          onChangeEnd: (value) {
                            controller.lightAction(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          const Text("定时任务 :"),
                          const SizedBox(width: 16),
                          const Expanded(child: SizedBox()),
                          CustomContainer(
                            onTap: () {
                              controller.choseDateTime(context);
                            },
                            borderRadius: BorderRadius.circular(25),
                            scaleValue: 0.9,
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: MyColors.background1.color,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Obx(() => Text(controller.dateUI.value)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          CustomContainer(
                            onTap: () {
                              controller.choseMinute(context);
                            },
                            borderRadius: BorderRadius.circular(25),
                            scaleValue: 0.9,
                            child: Container(
                              height: 30,
                              width: 66,
                              decoration: BoxDecoration(
                                color: MyColors.background1.color,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child:
                                    Obx(() => Text(controller.minuteUI.value)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
