class ApiPathUtil {
  ApiPathUtil._();

  //static const String springBootBaseUrl = "https://singlestep.cn/onehome";
  static const String springBootBaseUrl = "http://192.168.218.98:8080/onehome";

  static const String appInfo = "/app/info";
  static const String setLightTask = "/schedule";

  static const String getRadarAction = "/sensor/radar";
  static const String setRadarAction = "/sensor/set-radar";

  static const String getInfrared = "/sensor/infrared";
  static const String setInfrared = "/sensor/set-infrared";
}
