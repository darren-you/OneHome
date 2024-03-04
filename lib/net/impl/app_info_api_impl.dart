import '../api/app_info_api.dart';
import '../base/base_api.dart';
import '../../utils/api_path_util.dart';

class AppInfoApiImpl implements AppInfoApi {
  @override
  getAppInfo() {
    return BaseApiService.ableBaseUrlDio.get(ApiPathUtil.appInfo);
  }
}
