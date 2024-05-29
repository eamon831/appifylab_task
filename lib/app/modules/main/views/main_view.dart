import 'package:appifylab_task/app/modules/calls/calls_view/calls_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/chats/views/chats_view.dart';
import '/app/modules/communities/communities_view/communities_view.dart';
import '/app/modules/main/controllers/main_controller.dart';
import '/app/modules/main/model/menu_code.dart';
import '/app/modules/main/views/bottom_nav_bar.dart';
import '/app/modules/updates/views/update_view.dart';

// ignore: must_be_immutable
class MainView extends BaseView<MainController> {
  MainView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Obx(
        () => getPageOnSelectedMenu(controller.selectedMenuCode),
      ),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return BottomNavBar(onItemSelected: controller.onMenuSelected);
  }

  final ChatsView chatView = ChatsView();
  UpdateView? updateView;
  CommunitiesView? communitiesView;
  CallsView? callsView;

  Widget getPageOnSelectedMenu(MenuCode menuCode) {
    switch (menuCode) {
      case MenuCode.chats:
        return chatView;
      case MenuCode.updates:
        updateView ??= UpdateView();
        return updateView!;
      case MenuCode.communities:
        communitiesView ??= CommunitiesView();
        return communitiesView!;
      case MenuCode.calls:
        callsView ??= CallsView();
        return callsView!;
      default:
        return OtherView(
          viewParam: describeEnum(menuCode),
        );
    }
  }
}

class OtherView extends StatelessWidget {
  final String viewParam;

  const OtherView({required this.viewParam, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Other View: $viewParam'),
    );
  }
}
