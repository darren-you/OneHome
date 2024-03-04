import 'package:get/get.dart';

import '../machinepage/machine_page_vm.dart';
import '../machinepage/vo/device_card_vo.dart';

class RadarPageViewModel extends GetxController {
  final machinePageViewModel = Get.find<MachinePageViewModel>();
  final cardIndex = Get.arguments;

  late Rx<DeviceCardVO> cardModel;
  @override
  void onInit() {
    super.onInit();

    cardModel = machinePageViewModel.deviceCardVOList[cardIndex - 1];
  }
}
