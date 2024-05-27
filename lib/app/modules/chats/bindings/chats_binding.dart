import 'package:get/get.dart';

import '/app/modules/chats/controllers/chats_controller.dart';

class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsController>(
      () => ChatsController(),
    );
  }
}
