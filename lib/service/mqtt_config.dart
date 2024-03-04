import '../views/machinepage/config/board_config.dart';

class MqttConfig {
  static const String subTopic = 'onehome_info';
  static const String pubTopic = 'onehome_ctrl';
  static const String tickTopic = 'tick';

  static const String server = '124.221.158.155';
  static const int port = 1883;
  static const String clientID = BoardConfig.appID;
}
