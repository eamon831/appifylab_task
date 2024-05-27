import 'package:get/get.dart';

import '/app/global_modals/add_chat_dialouge/add_chat_modal_controller.dart';
import '/app/modules/chats/controllers/chats_controller.dart';

class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsController>(
      () => ChatsController(),
    );
    Get.lazyPut<AddChatModalController>(
      () => AddChatModalController(),
    );
  }
}
