import 'package:appifylab_task/app/model/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/chat_with_user/controllers/chat_with_user_controller.dart';

class ChatWithUserView extends BaseView<ChatWithUserController> {
  ChatWithUserView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar();
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: controller.firestore
                .collection(controller.tblChats)
                .doc(controller.chatId)
                .collection('messages')
                .orderBy('timestamp')
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final chatDocs = chatSnapshot.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) {
                  final msg = ChatMessage.fromDocument(chatDocs[index]);
                  return MessageBubble(
                    message: msg,
                    isMe: chatDocs[index]['senderId'] == controller.sender.uid,
                  );
                },
              );
            },
          ),
        ),
        Obx(
          () {
            return controller.selectedFile.value.path.isNotEmpty
                ? Image.file(
                    controller.selectedFile.value,
                    height: 100,
                    width: 100,
                  )
                : Container();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.controller,
                  decoration: const InputDecoration(
                    labelText: 'Send a message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: controller.sendMessage,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: controller.addFile,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const MessageBubble({
    required this.message,
    required this.isMe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            children: [
              if(message.type == 'image')
                Image.network(message.imageUrl??''),

              Text(
                message.text,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
