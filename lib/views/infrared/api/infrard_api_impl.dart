import 'package:onehome/views/infrared/api/infrard_api.dart';

import '../../../net/base/base_api.dart';
import '../../../utils/api_path_util.dart';

class InfrardApiImpl implements InfrardApi {
  @override
  getInfrardAction() {
    return BaseApiService.ableBaseUrlDio.get(ApiPathUtil.getInfrared);
  }

  @override
  setInfrardAction(bool action) {
    Map<String, dynamic> parame = {
      "action": action,
    };

    return BaseApiService.ableBaseUrlDio
        .get(ApiPathUtil.setInfrared, queryParameters: parame);
  }
}
