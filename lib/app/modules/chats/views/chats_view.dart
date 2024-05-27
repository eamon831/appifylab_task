import 'package:flutter/material.dart';
import '/app/core/base/base_view.dart';

import '/app/modules/chats/controllers/chats_controller.dart';

class ChatsView extends BaseView<ChatsController> {
  ChatsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    throw UnimplementedError();
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    throw UnimplementedError();
  }
}
