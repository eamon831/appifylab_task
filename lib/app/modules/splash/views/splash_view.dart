import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/splash/controllers/splash_controller.dart';

class SplashView extends BaseView<SplashController> {
  SplashView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
