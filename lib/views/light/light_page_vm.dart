import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onehome/utils/net_uitl.dart';
import 'package:onehome/views/light/light_task_api.dart';

import '../../components/input/custom_autoscroller_picker.dart';
import '../../components/input/custom_date_picker.dart';
import '../../components/view/custom_bottom_sheet.dart';
import '../../service/mqtt_config.dart';
import '../../service/mqtt_service.dart';
import '../machinepage/dto/message_info.dart';
import '../machinepage/machine_page_vm.dart';
import '../machinepage/vo/device_card_vo.dart';
import '../mainpage/nav_page_vm.dart';

class LightPageViewModel extends GetxController {
  final machinePageViewModel = Get.find<MachinePageViewModel>();
  final cardIndex = Get.arguments;
  late Rx<DeviceCardVO> cardModel;

  final navPageViewModel = Get.find<NavPageViewModel>();
  final mqttService = Get.find<MqttService>();
  final userInfoApi = Get.find<LightTaskApi>();
  late Map<String, List<String>> timeMap;

  var dateUI = '2024-02-29'.obs;
  var minuteUI = '00:00'.obs;

  var dateTime = '20240229T17:48:00';

  var sliderValue = 0.0.obs;

  void lightAction(double newLightValue) {
    final msg = SentMessage(bid: '1', did: '1', cmd: '${newLightValue.toInt()}')
        .toJson();

    mqttService.publishMessage(MqttConfig.pubTopic, jsonEncode(msg));

    final recTime = formatDate(DateTime.now(),
        [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss, '.', SSS]);
    navPageViewModel.operationalLog.writeln(recTime);
    navPageViewModel.operationalLog.writeln(jsonEncode(msg));
    navPageViewModel.operationalLog.writeln('\n');
  }

  void choseDateTime(BuildContext context) {
    showMyBottomSheet(
      context,
      showChild: CustomDatePicekr(
        title: "选择日期",
        selectNowDate: true,
        defaultSelectDateTime: DateTime.now(),
        startYear: DateTime.now().year,
        endYear: DateTime.now().year,
        enter: (selectTime) {
          debugPrint("选择日期: $selectTime");
          dateUI.value = DateFormat('yyyy-MM-dd').format(selectTime);

          _formatDateTime();
        },
      ),
    );
  }

  /// 选择时间
  Future<void> choseMinute(BuildContext context) async {
    showMyBottomSheet(
      context,
      showChild: TwoAutoScrollerPicker(
        title: "时间",
        dateList: timeMap,
        firstDefaultSelect: 0,
        secondDefaultSelect: 0,
        firstFontSize: 14,
        secondFontSize: 14,
        enter: (allSelectIndex) {
          String firstKey = timeMap.keys.elementAt(allSelectIndex[0]);
          String thirdValueOfFirstKey =
              timeMap[firstKey]!.elementAt(allSelectIndex[1]);

          minuteUI.value = '$firstKey:$thirdValueOfFirstKey';

          _formatDateTime();

          NetUtil.request(
            netFun: userInfoApi.setLightTask(dateTime),
            onDataSuccess: (rightData) async {
              SmartDialog.showToast(rightData);
            },
          );
        },
      ),
    );
  }

  Map<String, List<String>> _createHourMinuteMap() {
    var hourMinuteMap = <String, List<String>>{};

    for (int hour = 0; hour <= 24; hour++) {
      var minuteList = <String>[];
      for (int minute = 1; minute <= 59; minute++) {
        minuteList.add(minute.toString().padLeft(2, '0'));
      }
      hourMinuteMap[hour.toString().padLeft(2, '0')] = minuteList;
    }

    return hourMinuteMap;
  }

  void _formatDateTime() {
    // 将输入的日期和时间字符串拼接起来
    dateTime = '${dateUI.value}T${minuteUI.value}';
    debugPrint('选择时间ISO格式: $dateTime');
  }

  @override
  void onInit() {
    super.onInit();
    cardModel = machinePageViewModel.deviceCardVOList[Get.arguments - 1];
  }

  @override
  void onReady() {
    super.onReady();

    timeMap = _createHourMinuteMap();
  }
}
