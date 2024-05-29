import 'package:appifylab_task/app/model/receiver_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';
import '/app/core/values/app_colors.dart';
import '/app/modules/chats/controllers/chats_controller.dart';
import '../widget/chat_card.dart';

class ChatsView extends BaseView<ChatsController> {
  ChatsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('WhatsApp'),
      backgroundColor: const Color(0xFF128C7E),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (context) {
            return [
              // In this case, we need 5 popupmenuItems one for each option.
              const PopupMenuItem(
                child: Text(
                  'New Group',
                ),
              ),
              const PopupMenuItem(
                child: Text(
                  'New Broadcast',
                ),
              ),
              const PopupMenuItem(
                child: Text(
                  'Linked Devices',
                ),
              ),
              const PopupMenuItem(
                child: Text(
                  'Starred Messages',
                ),
              ),
              PopupMenuItem(
                onTap: controller.goToSettings,
                child: const Text('Settings'),
              ),
              PopupMenuItem(
                onTap: controller.logOut,
                child: const Text('Log Out'),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    final currentUID = FirebaseAuth.instance.currentUser?.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('tbl_users').snapshots(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = snapshot.data!.docs[index];
                final data = document.data()! as Map<String, dynamic>;
                final receiver = ReceiverUser.fromMap(data);
                final uid = data['uid'];

                if (uid != currentUID) {
                  return ChatCard(
                    receiver: receiver,
                    onTap: () => controller.startChat(
                      uid,
                      receiver,
                    ),
                  );
                } else {
                  controller.myUserObj = receiver;
                  return const SizedBox();
                }
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
