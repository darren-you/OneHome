import 'package:onehome/views/radar/api/radar_api.dart';

import '../../../net/base/base_api.dart';
import '../../../utils/api_path_util.dart';

class RadarApiImpl implements RadarApi {
  @override
  getRadarAction() {
    return BaseApiService.ableBaseUrlDio.get(ApiPathUtil.getRadarAction);
  }

  @override
  setRadarAction(bool action) {
    Map<String, dynamic> parame = {
      "action": action,
    };

    return BaseApiService.ableBaseUrlDio
        .get(ApiPathUtil.setRadarAction, queryParameters: parame);
  }
}
