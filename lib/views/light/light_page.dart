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
                  '${controller.sliderValue.value.toInt()}%',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Text(
              '台灯亮度',
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
                      """台灯的光强度一般用流明（Lumens）来衡量，而色温则用开尔文（Kelvin，K）来表示。色温对于阅读、观看电影、处理文档或写作等活动的舒适度有重要影响。以下是一些活动所推荐的色温范围：
\n阅读：对于阅读来说，建议使用色温在4000K到5000K之间的光源，这是中性到冷白光的范围。这样的色温有助于提高注意力和集中力，使得文字更清晰，减少视觉疲劳。
\n观看电影：观看电影时，较低的色温（2700K到3000K）会创造出温馨舒适的环境，类似于白炽灯的色温，适合放松和娱乐活动。
\n处理文档：处理文档时，中性白光（4000K左右）可以帮助提高工作效率，同时减少眼睛疲劳。
\n写作：写作时，色温在4000K到5000K之间的光源可以帮助提高思维清晰度和集中力。""",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                width: context.width,
                //height: 200,
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
