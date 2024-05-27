import 'package:appifylab_task/app/global_modals/add_chat_dialouge/add_chat_modal_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';
import '/app/core/widget/dialog_pattern.dart';
import '/app/global_modals/add_chat_dialouge/add_chat_modal_view.dart';

class ChatsController extends BaseController {
  final users = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUsers();
  }

  Future<void> getUsers() async {
    final users = await this.users.get();
    print(users.docs);
  }

  void addChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        if (Get.isRegistered<AddChatModalController>()) {
          Get.delete<AddChatModalController>();
        }
        Get.lazyPut<AddChatModalController>(
          () => AddChatModalController(),
          fenix: true,
        );
        return DialogPattern(
          title: 'Add Chat',
          subTitle: 'Add Chat Subtitle',
          child: AddChatModalView(),
        );
      },
    );
  }
}
