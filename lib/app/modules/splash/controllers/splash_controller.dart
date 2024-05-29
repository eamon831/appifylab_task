import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';
import '/app/routes/app_pages.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        auth.currentUser != null
            ? Get.offAllNamed(
                Routes.MAIN,
              )
            : Get.offAllNamed(
                Routes.LOGIN,
              );
      },
    );
  }
}
