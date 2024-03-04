// To parse this JSON data, do
//
//     final boardStatus = boardStatusFromJson(jsonString);

import 'dart:convert';

/// Iot设备在线状态
class BoardStatus {
  String bid;
  String status;

  BoardStatus({
    required this.bid,
    required this.status,
  });

  factory BoardStatus.fromJson(Map<String, dynamic> json) => BoardStatus(
        bid: json["bid"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "status": status,
      };
}

BoardStatus boardStatusFromJson(String str) =>
    BoardStatus.fromJson(json.decode(str));

String boardStatusToJson(BoardStatus data) => json.encode(data.toJson());

/// ESP设备
class Board {
  String bid;
  List<Device> devices;

  Board({
    required this.bid,
    required this.devices,
  });

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        bid: json["bid"],
        devices:
            List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
      };
}

Board boardFromJson(String str) => Board.fromJson(json.decode(str));

String boardToJson(Board data) => json.encode(data.toJson());

/// Iot设备挂载的传感器设备
class Device {
  String did;
  String name;
  String data;

  Device({
    required this.did,
    required this.name,
    required this.data,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        did: json["did"],
        name: json["name"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "did": did,
        "name": name,
        "data": data,
      };
}

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());
