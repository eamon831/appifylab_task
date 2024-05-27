import 'package:appifylab_task/app/global_modals/add_chat_dialouge/add_chat_modal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';
import '/app/core/widget/dialog_pattern.dart';
import '/app/global_modals/add_chat_dialouge/add_chat_modal_view.dart';

class ChatsController extends BaseController {
  void addChat(BuildContext context) {
    if(Get.isRegistered<AddChatModalController>()) {
      Get.delete<AddChatModalController>();
    }
    Get.lazyPut<AddChatModalController>(
      () => AddChatModalController(),
      fenix: true,
    );
    showDialog(
      context: context,
      builder: (context) {
        return DialogPattern(
          title: 'Add Chat',
          subTitle: 'Add Chat Subtitle',
          child: AddChatModalView(),
        );
      },
    );
  }
}
