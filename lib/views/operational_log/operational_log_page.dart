import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onehome/components/appbar/normal_appbar.dart';
import 'package:onehome/components/view/custom_body.dart';
import 'package:onehome/enumm/color_enum.dart';
import 'package:onehome/views/operational_log/operational_log_page_vm.dart';

class OperationalLogPage extends GetView<OperationalLogPageViewModel> {
  const OperationalLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('操作日志:${controller.navPageViewModel.operationalLog.toString()}');
    return CustomBody(
      appBar: const NormalAppBar(
          title: Text(
        '操作日志',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      backgroundColor: MyColors.background.color,
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                  child: Text(
                controller.navPageViewModel.operationalLog.toString(),
                textAlign: TextAlign.left,
              )),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
