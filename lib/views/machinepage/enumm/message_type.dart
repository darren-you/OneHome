/// 消息类型枚举
enum MeaageEnum {
  boardStatus(msgType: '0'),
  boardInfo(msgType: '1');

  final String msgType;

  const MeaageEnum({
    required this.msgType,
  });
}
