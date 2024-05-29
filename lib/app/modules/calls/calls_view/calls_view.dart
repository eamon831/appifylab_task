

import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/calls/calls_controllers/calls_controller.dart';

class CallsView extends BaseView<CallsController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text('Calls'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text('Calls'),
    );
  }
}
