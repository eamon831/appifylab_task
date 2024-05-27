import '/app/modules/chat_with_user/controllers/chat_with_user_controller.dart';
import 'package:get/get.dart';

class ChatWithUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatWithUserController>(
      () => ChatWithUserController(),
      fenix: true,
    );
  }
}
