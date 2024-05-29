import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/updates/controllers/update_controller.dart';

class UpdateView extends BaseView<UpdateController> {
  UpdateView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Updates',
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return const Center(
      child: Text('Updates View'),
    );
  }
}
