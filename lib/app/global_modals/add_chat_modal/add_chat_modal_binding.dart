import 'package:get/get.dart';

import 'add_chat_modal_controller.dart';

class AddChatModalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddChatModalController>(
      () => AddChatModalController(),
      fenix: true,
    );
  }
}
