/// 设备状态枚举
enum BoardStatusEnum {
  onLine(status: '1'),
  offLine(status: '0');

  final String status;

  const BoardStatusEnum({
    required this.status,
  });
}
