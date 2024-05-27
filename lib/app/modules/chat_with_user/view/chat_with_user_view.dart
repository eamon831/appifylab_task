import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/chat_with_user/controllers/chat_with_user_controller.dart';

class ChatWithUserView extends BaseView<ChatWithUserController> {
  ChatWithUserView({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar();
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.sendMessage,
          child: const Text('Send Message'),
        ),
        const Text('Chat with user'),
      ],
    );
  }
}
