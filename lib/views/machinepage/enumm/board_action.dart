/// 设备操作命令枚举
enum BoardActionEnum {
  // App 上线
  appOnLine(cmd: '1'),
  appOffLine(cmd: '0'),

  lightTurnOn(cmd: '1'),
  lightTurnOff(cmd: '0');

  final String cmd;

  const BoardActionEnum({
    required this.cmd,
  });
}
