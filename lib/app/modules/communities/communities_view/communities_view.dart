import 'package:appifylab_task/app/core/base/base_view.dart';
import 'package:flutter/material.dart';

import '/app/modules/communities/communities_controllers/communities_controller.dart';

class CommunitiesView extends BaseView<CommunitiesController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text('Communities'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text('Communities'),
    );
  }
}
