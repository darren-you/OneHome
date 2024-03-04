import 'package:get/get.dart';
import 'package:onehome/views/app_update/app_update_page.dart';
import 'package:onehome/views/app_update/app_update_page_vm.dart';
import 'package:onehome/views/humidity/humidity_page.dart';
import 'package:onehome/views/humidity/humidity_page_vm.dart';
import 'package:onehome/views/infrared/api/infrard_api.dart';
import 'package:onehome/views/infrared/api/infrard_api_impl.dart';
import 'package:onehome/views/infrared/infrared_page.dart';
import 'package:onehome/views/infrared/infrared_page_vm.dart';
import 'package:onehome/views/light/light_page_vm.dart';
import 'package:onehome/views/machinepage/machine_page_vm.dart';
import 'package:onehome/views/mainpage/nav_page_vm.dart';
import 'package:onehome/views/light/light_page.dart';
import 'package:onehome/views/light/light_task_api.dart';
import 'package:onehome/views/light/light_task_api_impl.dart';
import 'package:onehome/views/operational_log/operational_log_page.dart';
import 'package:onehome/views/radar/api/radar_api.dart';
import 'package:onehome/views/radar/api/radar_api_impl.dart';
import 'package:onehome/views/radar/radar_page.dart';
import 'package:onehome/views/radar/radar_page_vm.dart';
import 'package:onehome/views/temperature/temperature_page.dart';
import 'package:onehome/views/temperature/temperature_page_vm.dart';
import 'package:onehome/views/user/user_page_vm.dart';

import '../net/api/app_info_api.dart';
import '../utils/page_path_util.dart';
import '../net/impl/app_info_api_impl.dart';
import '../views/mainpage/nav_page.dart';
import '../views/operational_log/operational_log_page_vm.dart';

class AppRountes {
  static List<GetPage<dynamic>>? appRoutes = [
    // APP进入主页，导航栏界面
    GetPage(
      name: PagePathUtil.mainNavigationPage,
      page: () => const NavPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => NavPageViewModel());
          Get.lazyPut(() => MachinePageViewModel());
          Get.lazyPut(() => UserPageViewModel());
        },
      ),
    ),

    GetPage(
      name: PagePathUtil.operationalLogPage,
      page: () => const OperationalLogPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => OperationalLogPageViewModel());
        },
      ),
    ),
    GetPage(
      name: PagePathUtil.appUpdatePage,
      page: () => const AppUpdatePage(),
      binding: BindingsBuilder(
        () {
          // app信息请求API
          Get.lazyPut<AppInfoApi>(() => AppInfoApiImpl());
          Get.lazyPut(() => AppUpdatePageViewModel());
        },
      ),
    ),
    GetPage(
      name: PagePathUtil.lightPage,
      page: () => const LightPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<LightTaskApi>(() => LightTaskApiImpl());
          Get.lazyPut<LightPageViewModel>(() => LightPageViewModel());
        },
      ),
    ),
    GetPage(
      name: PagePathUtil.temperaturePage,
      page: () => const TemperaturePage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => TemperaturePageViewModel());
        },
      ),
    ),
    GetPage(
      name: PagePathUtil.humidityPage,
      page: () => const HumidityPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => HumidityPageViewModel());
        },
      ),
    ),
    GetPage(
      name: PagePathUtil.radarPage,
      page: () => const RadarPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<RadarApi>(() => RadarApiImpl());
          Get.lazyPut(() => RadarPageViewModel());
        },
      ),
    ),
    GetPage(
      name: PagePathUtil.infraredSensorPage,
      page: () => const InfraredPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<InfrardApi>(() => InfrardApiImpl());
          Get.lazyPut(() => InfraredPageViewModel());
        },
      ),
    ),
  ];
}
