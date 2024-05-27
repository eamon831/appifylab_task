import 'package:appifylab_task/app/core/model/page_state.dart';
import 'package:flutter/material.dart';

import '/app/core/base/base_controller.dart';

class AddChatModalController extends BaseController {
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  Future<void> addChat() async {
    updatePageState(PageState.LOADING);
    // delay
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        updatePageState(PageState.DEFAULT);
      },
    );
  }
}
