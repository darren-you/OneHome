import 'package:flutter/widgets.dart';

import '../../net/base/base_api.dart';
import '../../utils/api_path_util.dart';
import 'light_task_api.dart';

class LightTaskApiImpl implements LightTaskApi {
  @override
  setLightTask(String dateTime) {
    final queryParameters = {
      "dateTime": dateTime,
    };

    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.setLightTask, queryParameters: queryParameters);
  }
}
