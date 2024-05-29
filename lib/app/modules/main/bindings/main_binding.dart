import 'package:get/get.dart';

import '/app/modules/chats/controllers/chats_controller.dart';
import '/app/modules/communities/communities_controllers/communities_controller.dart';
import '/app/modules/main/controllers/main_controller.dart';
import '/app/modules/updates/controllers/update_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<MainController>(
        () => MainController(),
        fenix: true,
      )
      ..lazyPut<ChatsController>(
        () => ChatsController(),
        fenix: true,
      )
      ..lazyPut<UpdateController>(
        () => UpdateController(),
        fenix: true,
      )
      ..lazyPut<CommunitiesController>(
        () => CommunitiesController(),
        fenix: true,
      );
  }
}
