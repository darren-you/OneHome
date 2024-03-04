import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onehome/views/infrared/api/infrard_api.dart';

import '../../components/notification/custom_notification.dart';
import '../../utils/net_uitl.dart';
import '../machinepage/machine_page_vm.dart';
import '../machinepage/vo/device_card_vo.dart';

class InfraredPageViewModel extends GetxController {
  final infraredApi = Get.find<InfrardApi>();
  final machinePageViewModel = Get.find<MachinePageViewModel>();
  late Rx<DeviceCardVO> cardModel;

  var infraredLogicSwitch = false.obs;

  Future<void> _initInfraredLogicSwitch() async {
    NetUtil.request(
      netFun: infraredApi.getInfrardAction(),
      onDataSuccess: (rightData) async {
        debugPrint('红外开关状态 > > > $rightData');
        infraredLogicSwitch.value = rightData as bool;
      },
    );
  }

  Future<void> setInfraredLogicSwitch(bool action) async {
    NetUtil.request(
      netFun: infraredApi.setInfrardAction(action),
      onDataSuccess: (rightData) async {
        debugPrint('设置红外联动状态 > > > $rightData');
        infraredLogicSwitch.value = rightData as bool;
        CustomNotification.toast(Get.context!, '设置成功!');
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    cardModel = machinePageViewModel.deviceCardVOList[Get.arguments - 1];
    await _initInfraredLogicSwitch();
  }
}
