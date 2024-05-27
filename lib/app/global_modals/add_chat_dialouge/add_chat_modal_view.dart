import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/base/base_view.dart';
import '/app/core/values/app_colors.dart';
import '/app/core/widget/text_form_field_widget.dart';
import 'add_chat_modal_controller.dart';

class AddChatModalView extends BaseView<AddChatModalController> {
  AddChatModalView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: Get.back,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: controller.emailController,
            hintText: 'Email',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
          ),
          TextFormFieldWidget(
            controller: controller.phoneNumberController,
            hintText: 'Phone Number',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
          5.height,
          ElevatedButton(
            onPressed: controller.addChat,
            child: const Text('Add Chat'),
          ),
        ],
      ),
    );
  }
}
