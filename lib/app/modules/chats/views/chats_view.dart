import 'package:appifylab_task/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '/app/core/values/app_colors.dart';
import '/app/modules/chats/controllers/chats_controller.dart';

class ChatsView extends BaseView<ChatsController> {
  ChatsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar();
  }

  @override
  Widget body(BuildContext context) {
    final currentUID = FirebaseAuth.instance.currentUser?.uid;
    print('currentUID: $currentUID');
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('tbl_users').snapshots(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              final data = document.data()! as Map<String, dynamic>;
              final uid = data['uid'];
              if (uid != currentUID) {
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['email']),
                  onTap: () {
                    Get.toNamed(
                      Routes.CHAT_WITH_USER,
                      arguments: {
                        'uid': uid,
                        'name': data['name'],
                        'data': data,
                      },
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Chat $index'),
          subtitle: Text('Chat Subtitle $index'),
        );
      },
    );
  }

  @override
  Widget floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.buttonBgColor,
      onPressed: () => controller.addChat(
        globalKey.currentContext!,
      ),
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
