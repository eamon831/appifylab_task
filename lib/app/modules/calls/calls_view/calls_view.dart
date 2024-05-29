import 'package:appifylab_task/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/calls/calls_controllers/calls_controller.dart';

class CallsView extends BaseView<CallsController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      title: const Text('Calls'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => controller.scanBarcode(context),
              child: const Text('Scan Barcode'),
            ),
            ElevatedButton(
              onPressed: () => controller.scanBluetooth(context),
              child: const Text('Scan Bluetooth'),
            ),
          ],
        ),
      ],
    );
  }
}
