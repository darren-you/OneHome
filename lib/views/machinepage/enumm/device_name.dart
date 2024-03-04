import '../../../utils/assert_util.dart';

final deviceNameMap = {
  '1': '台灯',
  '2': '温度传感器',
  '3': '湿度传感器',
  '4': '雷达传感器',
  '5': '热敏红外',
};

final devicePicMap = {
  '1': AssertUtil.picLight,
  '2': AssertUtil.picTemp,
  '3': AssertUtil.picWater,
  '4': AssertUtil.picLadar,
  '5': AssertUtil.picLadar,
};

final cmdPicMap = {
  '1': AssertUtil.iconPower,
  '2': null,
  '3': null,
  '4': null,
  '5': null,
};

/// Board挂载的设备名枚举
enum DeviceName {
  deskLamp(nameID: '1'),
  temperatureSensor(nameID: '2'),
  humiditySensor(nameID: '3'),
  radarSensor(nameID: '4'),
  infraredSensor(nameID: '5');

  final String nameID;

  const DeviceName({
    required this.nameID,
  });
}

String getDeviceNameByName(String deviceNameID) {
  return deviceNameMap[deviceNameID] ?? '';
}

String getDevicePicByName(String deviceNameID) {
  return devicePicMap[deviceNameID] ?? '';
}

String getCmdPicByName(String deviceNameID) {
  return cmdPicMap[deviceNameID] ?? '';
}
