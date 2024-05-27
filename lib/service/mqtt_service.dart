import 'dart:async';
import 'dart:convert';

import 'package:onehome/service/mqtt_config.dart';
import 'package:typed_data/typed_data.dart' as typed;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

typedef ConnectSuccessCallback = Future<void> Function(MqttServerClient client);
typedef DisconnectedCallback = Future<void> Function();
typedef SubscribeCallback = Future<void> Function(String topic);
typedef RecMessageCallback = Future<void> Function(String topic, String msg);

/// Mqtt连接Demo: https://github.com/shamblett/mqtt_client/blob/master/example/mqtt_server_client.dart

class MqttService extends GetxService {
  late final ConnectSuccessCallback? connectSuccessCallback;
  late final DisconnectedCallback? disconnectedCallback;
  late final SubscribeCallback? subscribeCallback;
  late final RecMessageCallback? recMessageCallback;

  static final MqttService _mqttService = MqttService._internal();
  static final MqttServerClient _mqttClient = MqttServerClient.withPort(
      MqttConfig.server, MqttConfig.clientID, MqttConfig.port);

  MqttService._internal();

  factory MqttService() {
    return _mqttService;
  }

  /// 连接MQTT服务器
  Future<void> connect({
    ConnectSuccessCallback? connectSuccessCallback,
    SubscribeCallback? subscribeCallback,
    RecMessageCallback? recMessageCallback,
    DisconnectedCallback? disconnectedCallback,
  }) async {
    this.connectSuccessCallback = connectSuccessCallback;
    this.subscribeCallback = subscribeCallback;
    this.recMessageCallback = recMessageCallback;
    this.disconnectedCallback = disconnectedCallback;

    _mqttClient.logging(on: false);
    _mqttClient.setProtocolV311(); // 3.1.1版本
    _mqttClient.keepAlivePeriod = 5;
    _mqttClient.onConnected = onConnected;
    _mqttClient.onSubscribed = onSubscribed;
    _mqttClient.onDisconnected = onDisconnected;
    _mqttClient.autoReconnect = true;

    /// 遗嘱消息
    final connectionMessage = MqttConnectMessage()
        .withClientIdentifier('遗嘱 ID  //c12w2121xxxxxxx')
        .withWillTopic('遗嘱 topic 39271')
        .withWillMessage('遗嘱 message 08301')
        .withWillQos(MqttQos.atLeastOnce);
    _mqttClient.connectionMessage = connectionMessage;

    try {
      await _mqttClient.connect();
    } catch (e) {
      debugPrint('Mqtt 连接错误: $e ❌');
      // CustomNotification.notice(Get.context!, "连接❌");
      disonnect();
      disconnectedCallback?.call();
    }
  }

  /// 连接成功回调
  void onConnected() {
    debugPrint('Mqtt 连接成功✅');
    // CustomNotification.notice(Get.context!, '连接✅');
    connectSuccessCallback?.call(_mqttClient);
    _handleMqttMessage();
  }

  /// 订阅成功回调
  void onSubscribed(String topic) {
    debugPrint('Mqtt 订阅: $topic ✅');
    //CustomNotification.toast(Get.context!, '订阅 $topic ✅');
    subscribeCallback?.call(topic);
  }

  /// 处理接收消息
  void _handleMqttMessage() {
    _mqttClient.updates?.listen(
      (List<MqttReceivedMessage<MqttMessage>>? messageList) {
        final MqttPublishMessage originMessage =
            messageList![0].payload as MqttPublishMessage;

        final String topic = messageList[0].topic;
        final String message = utf8.decode(originMessage.payload.message);

        //debugPrint('mqtt 消息 topic: $topic message: $message');
        recMessageCallback?.call(topic, message);
      },
    );
  }

  /// MQTT连接断开回调函数
  void onDisconnected() {
    debugPrint('Mqtt 断开连接❌');
    // CustomNotification.notice(Get.context!, '连接❌');
    disconnectedCallback?.call();
  }

  /// 订阅MQTT主题
  void subscribe(String topic) {
    _mqttClient.subscribe(topic, MqttQos.atLeastOnce);
  }

  /// 发送MQTT消息
  Future<void> publishMessage(String topic, String message) async {
    final builder = MqttClientPayloadBuilder();
    final messageBytes = utf8.encode(message);
    final messageBuffer = typed.Uint8Buffer();
    messageBuffer.addAll(messageBytes);
    builder.addBuffer(messageBuffer);

    _mqttClient.publishMessage(topic, MqttQos.atLeastOnce, messageBuffer);

    debugPrint('mqtt 发送消息 topic: $topic message: $message');
  }

  /// 取消订阅MQTT主题
  void unsubscribe(String topic) {
    _mqttClient.unsubscribe(topic);
  }

  /// 关闭连接
  void disonnect() {
    _mqttClient.disconnect();
  }
}
