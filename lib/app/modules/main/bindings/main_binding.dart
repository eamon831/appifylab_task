import 'package:get/get.dart';

import '/app/modules/main/controllers/main_controller.dart';
import '/app/modules/chats/controllers/chats_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );
    Get.lazyPut<ChatsController>(
      () => ChatsController(),
      fenix: true,
    );
  }
}
