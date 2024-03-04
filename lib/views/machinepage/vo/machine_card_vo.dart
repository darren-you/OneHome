class MachineCardVO {
  late int id; // 设备ID
  late String pic; // 设备图片
  late String iconPath; // icon
  late bool status; // 状态
  late String name; // 设备名
  late String home = '全屋'; // 归属房间
  late bool quickAbility; // 是否支持快捷操作
  late bool turnOn;
  late Function() onTap = () {}; // 点击卡片事件
  late Function() quickAction = () {}; // 快捷操作VO

  MachineCardVO(this.id, this.pic, this.iconPath, this.status, this.name,
      this.home, this.quickAbility, this.turnOn, this.onTap, this.quickAction);
}
