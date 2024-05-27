import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '/app/core/values/app_colors.dart';
import '/app/modules/chats/controllers/chats_controller.dart';

class ChatsView extends BaseView<ChatsController> {
  ChatsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar();
  }

  @override
  Widget body(BuildContext context) {
    return const Center(
      child: Text(
        'ChatsView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.buttonBgColor,
      onPressed: () => controller.addChat(
        globalKey.currentContext!,
      ),
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
