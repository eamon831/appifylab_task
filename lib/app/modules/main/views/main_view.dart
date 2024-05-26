import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/main/controllers/main_controller.dart';
import '/app/modules/main/model/menu_code.dart';
import '/app/modules/main/views/bottom_nav_bar.dart';

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

  final ChatView chatView = const ChatView();
  UpdatesView? favoriteView;
  CommunitiesView? settingsView;

  Widget getPageOnSelectedMenu(MenuCode menuCode) {
    switch (menuCode) {
      case MenuCode.chats:
        return chatView;
      case MenuCode.updates:
        favoriteView ??= const UpdatesView();
        return favoriteView!;
      case MenuCode.communities:
        settingsView ??= const CommunitiesView();
        return settingsView!;
      default:
        return OtherView(
          viewParam: describeEnum(menuCode),
        );
    }
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home View'),
    );
  }
}

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Favorite View'),
    );
  }
}

class CommunitiesView extends StatelessWidget {
  const CommunitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings View'),
    );
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
