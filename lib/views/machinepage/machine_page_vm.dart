import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:onehome/service/mqtt_config.dart';
import 'package:onehome/service/mqtt_service.dart';
import 'package:onehome/utils/page_path_util.dart';
import 'package:onehome/views/machinepage/config/board_config.dart';
import 'package:onehome/views/machinepage/dto/board_info.dart';
import 'package:onehome/views/machinepage/dto/message_info.dart';
import 'package:onehome/views/machinepage/enumm/board_action.dart';
import 'package:onehome/views/machinepage/enumm/device_name.dart';
import 'package:onehome/views/machinepage/vo/device_card_vo.dart';
import 'package:onehome/views/mainpage/nav_page_vm.dart';

class MachinePageViewModel extends GetxController {
  final mqttService = Get.find<MqttService>();
  final navPageViewModel = Get.find<NavPageViewModel>();

  var selectHomeName = '全屋'.obs;
  RxList<Rx<DeviceCardVO>> deviceShowCardVOList = <Rx<DeviceCardVO>>[].obs;

  final List<String> dHomeList = [
    '全屋',
    '卧室-1',
    '客厅',
    '书房',
    '厨房',
    '卧室-2',
    '卧室-3',
  ];

  final List<Rx<DeviceCardVO>> deviceCardVOList = [
    // ESP板ID_1 > 台灯
    DeviceCardVO(
      bid: '1',
      did: '1',
      name: '1',
      dName: getDeviceNameByName('1'),
      dHome: '卧室-1',
      dPic: getDevicePicByName('1'),
      cmdPic: getCmdPicByName('1'),
      data: '0',
      onTap: () {
        Get.toNamed(PagePathUtil.lightPage);
      },
      cmd: () {},
    ).obs,

    // ESP板ID_2 > 温度、湿度、雷达
    DeviceCardVO(
      bid: '2',
      did: '1',
      name: '2',
      dName: getDeviceNameByName('2'),
      dHome: '客厅',
      dPic: getDevicePicByName('2'),
      cmdPic: getCmdPicByName('2'),
      onTap: () {
        Get.toNamed(PagePathUtil.temperaturePage, arguments: 2);
      },
      cmd: () {},
    ).obs,
    DeviceCardVO(
      bid: '2',
      did: '2',
      name: '3',
      dName: getDeviceNameByName('3'),
      dHome: '客厅',
      dPic: getDevicePicByName('3'),
      cmdPic: getCmdPicByName('3'),
      onTap: () {
        Get.toNamed(PagePathUtil.humidityPage, arguments: 3);
      },
      cmd: () {},
    ).obs,
    DeviceCardVO(
      bid: '2',
      did: '3',
      name: '4',
      dName: getDeviceNameByName('4'),
      dHome: '书房',
      dPic: getDevicePicByName('4'),
      cmdPic: getCmdPicByName('4'),
      onTap: () {
        Get.toNamed(PagePathUtil.radarPage, arguments: 4);
      },
      cmd: () {},
    ).obs,
    DeviceCardVO(
      bid: '2',
      did: '3',
      name: '5',
      dName: getDeviceNameByName('5'),
      dHome: '卧室-1',
      dPic: getDevicePicByName('5'),
      cmdPic: getCmdPicByName('5'),
      onTap: () {
        Get.toNamed(PagePathUtil.infraredSensorPage, arguments: 5);
      },
      cmd: () {},
    ).obs,
  ];

  void buildShowCardList() {
    deviceShowCardVOList.clear();
    if (selectHomeName.value == '全屋') {
      deviceShowCardVOList.addAll(deviceCardVOList);
    } else {
      for (var originCard in deviceCardVOList) {
        if (originCard.value.dHome == selectHomeName.value) {
          deviceShowCardVOList.add(originCard);
        }
      }
    }
  }

  /// 连接成功回调函数
  Future<void> connectSuccessCallback(MqttServerClient mqttServerClient) async {
    mqttService.subscribe(MqttConfig.subTopic);
  }

  /// 订阅成功回调
  Future<void> subscribeCallback(String topic) async {
    if (topic == MqttConfig.subTopic) {
      final msg = SentMessage(
              bid: BoardConfig.appID,
              did: '0',
              cmd: BoardActionEnum.appOnLine.cmd)
          .toJson();

      mqttService.publishMessage(MqttConfig.pubTopic, jsonEncode(msg));
    }
  }

  /// 收到Mqtt消息,处理函数
  Future<void> recMsg(String topic, String msg) async {
    final recTime = formatDate(DateTime.now(),
        [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss, '.', SSS]);

    navPageViewModel.operationalLog.writeln(recTime);
    navPageViewModel.operationalLog.writeln(msg);
    navPageViewModel.operationalLog.writeln('\n');

    if (topic == MqttConfig.subTopic) {
      debugPrint('mqtt 收到消息 time: $recTime message: $msg');
      RecMessage reMsg = recMessageFromJson(msg);
      final data = reMsg.data;

      if (data is BoardStatus) {
        // Board状态信息
        for (var deviceCardVO in deviceCardVOList) {
          if (deviceCardVO.value.bid == data.bid) {
            deviceCardVO.update((oldDeviceCardVO) {
              oldDeviceCardVO!.bStatus = data.status;
            });
          }
        }
      } else if (data is Board) {
        // Board设备信息
        for (var deviceCardVO in deviceCardVOList) {
          if (deviceCardVO.value.bid == data.bid) {
            for (var sensor in data.devices) {
              if (deviceCardVO.value.did == sensor.did) {
                deviceCardVO.update((oldDeviceCardVO) {
                  debugPrint(
                      '更新 ${deviceCardVO.value.dName} data:${sensor.data}');
                  //oldDeviceCardVO!.bStatus = BoardConfig.onLine;
                  oldDeviceCardVO!.data = sensor.data;
                });
              }
            }
          }
        }
      }
    }
  }

  /// 控制台灯的亮度
  void lightQuickAction(DeviceCardVO deviceCardVO) {
    final lightValue = int.parse(deviceCardVO.data!) > 0 ? '0' : '100';
    final msg = SentMessage(
            bid: deviceCardVO.bid, did: deviceCardVO.did, cmd: lightValue)
        .toJson();

    mqttService.publishMessage(MqttConfig.pubTopic, jsonEncode(msg));

    final recTime = formatDate(DateTime.now(),
        [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss, '.', SSS]);
    navPageViewModel.operationalLog.writeln(recTime);
    navPageViewModel.operationalLog.writeln(jsonEncode(msg));
    navPageViewModel.operationalLog.writeln('\n');
  }

  @override
  void onInit() async {
    super.onInit();

    buildShowCardList();

    // 连接mqtt
    await mqttService.connect(
      connectSuccessCallback: connectSuccessCallback,
      subscribeCallback: subscribeCallback,
      recMessageCallback: recMsg,
    );
  }
}
