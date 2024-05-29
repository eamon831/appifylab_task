import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/settings/controllers/settings_controller.dart';

class SettingsViews extends BaseView<SettingsController> {
  SettingsViews({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('WhatsApp'),
      backgroundColor: const Color(0xFF128C7E),
      actions: [],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Settings'),
        ],
      ),
    );
  }
}
