import 'package:onehome/views/machinepage/config/board_config.dart';

class DeviceCardVO {
  late String bid; // ESP开发板ID
  late String did; // Device ID
  late String name; // Device的nameID
  late String? data; // Device数据

  late String bStatus; // ESP开发板状态

  late String dName; // Device名
  late String dPic; // Device图片
  late String? cmdPic; // Device操作Icon
  late String dHome; // Device归属房间

  late Function()? onTap = () {}; // 点击卡片
  late Function()? cmd = () {}; // Devic操作

  DeviceCardVO({
    required this.bid,
    required this.did,
    required this.name,
    this.data,
    this.bStatus = BoardConfig.offLine,
    required this.dName,
    required this.dPic,
    required this.cmdPic,
    this.dHome = '全屋',
    required this.onTap,
    required this.cmd,
  });
}
