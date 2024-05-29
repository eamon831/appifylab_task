import 'package:appifylab_task/app/core/model/page_state.dart';
import 'package:appifylab_task/app/model/receiver_user.dart';
import 'package:appifylab_task/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';
import '/app/core/widget/dialog_pattern.dart';
import '/app/global_modals/add_chat_modal/add_chat_modal_controller.dart';
import '/app/global_modals/add_chat_modal/add_chat_modal_view.dart';

class ChatsController extends BaseController {
  ReceiverUser? myUserObj;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> startChat(
    String otherUserId,
    ReceiverUser receiverUser,
  ) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return;

    if (!(await authenticate())) {
      return;
    }

    updatePageState(PageState.LOADING);

    // Check if a chat already exists between the current user and the other user
    final chatQuery = await firestore
        .collection(tblChats)
        .where(
          'participants',
          arrayContains: currentUser.uid,
        )
        .get();

    String? chatId;

    for (final doc in chatQuery.docs) {
      final participants = List<String>.from(
        doc['participants'],
      );
      if (participants.contains(otherUserId)) {
        chatId = doc.id;
        break;
      }
    }

    // If no chat exists, create a new one
    if (chatId == null) {
      final newChatDoc = await firestore.collection(tblChats).add(
        {
          'participants': [currentUser.uid, otherUserId],
        },
      );
      chatId = newChatDoc.id;
    }
    updatePageState(PageState.DEFAULT);

    Get.toNamed(
      Routes.CHAT_WITH_USER,
      arguments: {
        'receiver': receiverUser,
        'chatId': chatId,
      },
    );
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

  Future? goToSettings() => Get.toNamed(
        Routes.SETTINGS,
        arguments: {
          'user': myUserObj,
        },
      );

  void logOut() {
    auth.signOut();
    Get.offAllNamed(
      Routes.SPLASH,
    );
  }
}
