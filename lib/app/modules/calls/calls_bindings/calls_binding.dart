import 'package:get/get.dart';

import '/app/modules/calls/calls_controllers/calls_controller.dart';

class CallsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallsController>(
      () => CallsController(),
    );
  }
}
