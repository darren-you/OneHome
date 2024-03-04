// To parse this JSON data, do
//
//     final recMessage = recMessageFromJson(jsonString);
import 'dart:convert';

import 'package:onehome/views/machinepage/enumm/message_type.dart';

import 'board_info.dart';

/// 来自Iot设备的消息
class RecMessage {
  String msgType;
  dynamic data;

  RecMessage({
    required this.msgType,
    required this.data,
  });

  factory RecMessage.fromJson(Map<String, dynamic> json) {
    dynamic data;
    if (json['data'] is Map<String, dynamic> &&
        json['msgType'] == MeaageEnum.boardStatus.msgType) {
      data = BoardStatus.fromJson(json['data']);
    } else if (json['data'] is Map<String, dynamic> &&
        json['msgType'] == MeaageEnum.boardInfo.msgType) {
      data = Board.fromJson(json['data']);
    } else {
      throw Exception('Unrecognized data type');
    }

    return RecMessage(
      msgType: json['msgType'],
      data: data,
    );
  }

  Map<String, dynamic> toJson() => {
        'msgType': msgType,
        'data': data is BoardStatus
            ? (data as BoardStatus).toJson()
            : (data as Board).toJson(),
      };
}

RecMessage recMessageFromJson(String str) =>
    RecMessage.fromJson(json.decode(str));

/// App发送给Iot设备的消息
class SentMessage {
  String bid;
  String did;
  String cmd;

  SentMessage({
    required this.bid,
    required this.did,
    required this.cmd,
  });

  factory SentMessage.fromJson(Map<String, dynamic> json) => SentMessage(
        bid: json["bid"],
        did: json["did"],
        cmd: json["cmd"],
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "did": did,
        "cmd": cmd,
      };
}

SentMessage sentMessageFromJson(String str) =>
    SentMessage.fromJson(json.decode(str));

String sentMessageToJson(SentMessage data) => json.encode(data.toJson());
