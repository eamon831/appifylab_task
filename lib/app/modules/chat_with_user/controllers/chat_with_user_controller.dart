import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';

class ChatWithUserController extends BaseController {

  late Map<String,dynamic> data;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    data = args['data'];
    logger.i('data: $data');

  }
}
