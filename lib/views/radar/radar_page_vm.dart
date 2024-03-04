import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:onehome/components/notification/animated_toast.dart';
import 'package:onehome/components/notification/custom_notification.dart';
import 'package:onehome/utils/net_uitl.dart';
import 'package:onehome/views/radar/api/radar_api.dart';

import '../machinepage/machine_page_vm.dart';
import '../machinepage/vo/device_card_vo.dart';

class RadarPageViewModel extends GetxController {
  final radarApi = Get.find<RadarApi>();
  final machinePageViewModel = Get.find<MachinePageViewModel>();
  late Rx<DeviceCardVO> cardModel;

  var ladarLogicSwitch = false.obs;

  Future<void> _initLadarLogicSwitch() async {
    NetUtil.request(
      netFun: radarApi.getRadarAction(),
      onDataSuccess: (rightData) async {
        debugPrint('雷达开关状态 > > > $rightData');
        ladarLogicSwitch.value = rightData as bool;
      },
    );
  }

  Future<void> setLadarLogicSwitch(bool action) async {
    NetUtil.request(
      netFun: radarApi.setRadarAction(action),
      onDataSuccess: (rightData) async {
        debugPrint('设置雷达联动状态 > > > $rightData');
        ladarLogicSwitch.value = rightData as bool;
        CustomNotification.toast(Get.context!, '设置成功!');
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    cardModel = machinePageViewModel.deviceCardVOList[Get.arguments - 1];
    await _initLadarLogicSwitch();
  }
}
