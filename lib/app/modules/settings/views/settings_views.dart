import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/settings/controllers/settings_controller.dart';

class SettingsViews extends BaseView<SettingsController> {
  SettingsViews({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('Settings'),
      backgroundColor: const Color(0xFF128C7E),
      actions: const [],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Obx(
            () => CircleAvatar(
              radius: 100,
              backgroundImage: Image.network(
                controller.myUserObj.value?.photoUrl ?? '',
                fit: BoxFit.cover,
              ).image,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: controller.changeProfileImage,
          child: const Text('Change Profile Picture'),
        ),
      ],
    );
  }
}
