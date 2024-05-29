import 'package:appifylab_task/app/core/widget/label_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/settings/controllers/settings_controller.dart';

class SettingsViews extends BaseView<SettingsController> {
  SettingsViews({super.key});

  final labelValue = const LabelValue(
    label: 'label',
    value: 'value',
    labelFontSize: 20,
    valueFontSize: 18,
    labelFontWeight: 700,
    valueFontWeight: 600,
  );

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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Obx(
        () => Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: Image.network(
                  controller.myUserObj.value?.photoUrl ?? '',
                  fit: BoxFit.cover,
                ).image,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.changeProfileImage,
              child: const Text('Change Profile Picture'),
            ),
            const SizedBox(height: 20),
            labelValue.copyWith(
              label: 'Name',
              value: controller.myUserObj.value?.name ?? '',
            ),
            labelValue.copyWith(
              label: 'Email',
              value: controller.myUserObj.value?.email ?? '',
            ),
            labelValue.copyWith(
              label: 'Phone',
              value: controller.myUserObj.value?.phone ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
