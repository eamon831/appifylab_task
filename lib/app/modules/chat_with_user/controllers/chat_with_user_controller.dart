import 'package:appifylab_task/app/model/receiver_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';

class ChatWithUserController extends BaseController {
  final controller = TextEditingController();

  late ReceiverUser user;
  late String chatId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      user = args['receiver'];
      chatId = args['chatId'];
    }
    logger.i('user: ${user.toMap()}, chatId: $chatId');
  }

  Future<void> sendMessage() async {
    if (controller.text.isEmpty) return;

    final user = auth.currentUser;
    if (user != null) {
      await firestore
          .collection(tblChats)
          .doc(chatId)
          .collection('messages')
          .add(
        {
          'text': controller.text,
          'senderId': user.uid,
          'timestamp': Timestamp.now(),
          'type': 'text',
        },
      );
      controller.clear();
    }
  }
}
