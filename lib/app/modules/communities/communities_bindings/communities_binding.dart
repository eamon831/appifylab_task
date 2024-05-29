import 'package:get/get.dart';

import '/app/modules/communities/communities_controllers/communities_controller.dart';

class CommunitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunitiesController>(
      () => CommunitiesController(),
      fenix: true,
    );
  }
}
