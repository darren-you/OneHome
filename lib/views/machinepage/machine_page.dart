import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:onehome/enumm/appbar_enum.dart';
import 'package:onehome/enumm/color_enum.dart';
import 'package:onehome/utils/assert_util.dart';
import 'package:onehome/views/machinepage/machine_page_vm.dart';
import 'package:onehome/views/machinepage/config/board_config.dart';
import 'package:onehome/views/machinepage/enumm/device_name.dart';

import '../../components/container/custom_container.dart';
import '../../components/view/custom_body.dart';

Widget setCardStatus(MachinePageViewModel controller, int cardIndex) {
  //final cardVO = controller.deviceCardVOList[cardIndex].value;
  if (controller.deviceCardVOList[cardIndex].value.name ==
      DeviceName.deskLamp.nameID) {
    return Obx(
      () => controller.deviceCardVOList[cardIndex].value.bStatus ==
              BoardConfig.onLine
          ? CustomContainer(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                controller.lightQuickAction(
                    controller.deviceCardVOList[cardIndex].value);
              },
              child: Container(
                height: 36,
                width: 36,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: int.parse(controller
                              .deviceCardVOList[cardIndex].value.data!) >
                          0
                      ? Colors.blue
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SvgPicture.asset(
                  AssertUtil.iconPower,
                ),
              ),
            )
          : const SizedBox(),
    );
  } else if (controller.deviceCardVOList[cardIndex].value.name ==
      DeviceName.temperatureSensor.nameID) {
    return Obx(
      () => Text(
        controller.deviceCardVOList[cardIndex].value.data == null
            ? ''
            : '${controller.deviceCardVOList[cardIndex].value.data}°C',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  } else if (controller.deviceCardVOList[cardIndex].value.name ==
      DeviceName.humiditySensor.nameID) {
    return Obx(
      () => Text(
        controller.deviceCardVOList[cardIndex].value.data == null
            ? ''
            : '${controller.deviceCardVOList[cardIndex].value.data}%',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  } else if (controller.deviceCardVOList[cardIndex].value.name ==
      DeviceName.radarSensor.nameID) {
    return Obx(
      () => Text(
        controller.deviceCardVOList[cardIndex].value.data == "1" ? '有人' : '无人',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
  return const SizedBox();
}

class MachinePage extends GetView<MachinePageViewModel> {
  const MachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        enableAppBarPadding: false,
        scroller: false,
        body: Stack(
          children: [
            SizedBox(
              width: context.width,
              height: context.height,
              child: ListView(
                children: [
                  SizedBox(
                      height: context.mediaQueryPadding.top +
                          AppBarOptions.hight50.height +
                          16),
                  Obx(
                    () => Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      //spacing: 12,
                      runSpacing: 12,
                      children: List.generate(
                        controller.deviceShowCardVOList.length,
                        (index) {
                          return CustomContainer(
                            margin: const EdgeInsets.only(left: 12),
                            onTap: () {
                              controller
                                  .deviceShowCardVOList[index].value.onTap!();
                              debugPrint("点击回调函数触发");
                            },
                            bgAnim: false,
                            color: Colors.white,
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(16),
                            duration: const Duration(milliseconds: 200),
                            scaleValue: 0.96,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              width: (context.width - 36) / 2,
                              height: (context.width - 36) / 2.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 36,
                                        width: 36,
                                        child: Image.asset(controller
                                            .deviceShowCardVOList[index]
                                            .value
                                            .dPic),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      setCardStatus(controller, index),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(
                                    () => Row(
                                      children: [
                                        Text(
                                            controller
                                                .deviceShowCardVOList[index]
                                                .value
                                                .dName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const Text(
                                          ' | ',
                                          style:
                                              TextStyle(color: Colors.black12),
                                        ),
                                        controller.deviceShowCardVOList[index]
                                                    .value.bStatus ==
                                                BoardConfig.onLine
                                            ? const Text('在线',
                                                style: TextStyle(
                                                    color: Colors.green))
                                            : Text('离线',
                                                style: TextStyle(
                                                    color: MyColors
                                                        .textSecond.color)),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 4),
                                  // 分配房间
                                  Text(
                                    controller.deviceShowCardVOList[index].value
                                        .dHome,
                                    style: TextStyle(
                                        color: MyColors.textSecond.color),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // 底部状态栏加自定义AppBar
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(top: context.mediaQueryPadding.top),
                color: Colors.white,
                height: context.mediaQueryPadding.top +
                    AppBarOptions.hight50.height,
                child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.dHomeList.length,
                      itemBuilder: (context, index) {
                        return CustomContainer(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          onTap: () {
                            controller.selectHomeName.value =
                                controller.dHomeList[index];
                            controller.buildShowCardList();
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Obx(() => Container(
                                decoration: BoxDecoration(
                                    color: controller.selectHomeName.value ==
                                            controller.dHomeList[index]
                                        ? MyColors.cardGreen.color
                                        : MyColors.background1.color,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    Text(
                                      controller.dHomeList[index],
                                      style: TextStyle(
                                        color:
                                            controller.selectHomeName.value ==
                                                    controller.dHomeList[index]
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              )),
                        );
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
