import 'dart:io';

import 'package:appifylab_task/app/core/model/page_state.dart';
import 'package:appifylab_task/app/model/chat_message.dart';
import 'package:appifylab_task/app/model/receiver_user.dart';
import 'package:appifylab_task/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:camera/camera.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '/app/core/base/base_controller.dart';

class ChatWithUserController extends BaseController {
  final msgController = TextEditingController();
  late User sender = auth.currentUser!;
  late ReceiverUser receiverUser;
  late String chatId;
  final selectedFile = File('').obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      receiverUser = args['receiver'];
      chatId = args['chatId'];
    }
  }

  Future<void> sendMessage() async {
    if (msgController.text.isEmpty || selectedFile.value.path.isEmptyOrNull) {
      return;
    }

    final user = auth.currentUser;
    if (user != null) {
      updatePageState(PageState.LOADING);

      try {
        final msgRef = firestore
            .collection(tblChats)
            .doc(chatId)
            .collection('messages')
            .doc();

        // Create a ChatMessage instance with text type initially
        final ChatMessage message = ChatMessage(
          senderId: user.uid,
          text: msgController.text,
          type: 'text',
          timestamp: Timestamp.now(),
        );

        // Set the initial message data in Firestore
        await msgRef.set(message.toMap());

        // Check if a file is selected
        if (selectedFile.value.path.isNotEmpty) {
          final fileExtension =
              path.extension(selectedFile.value.path).toLowerCase();
          String fileType;

          // Determine the file type based on the extension
          if (['.jpg', '.jpeg', '.png', '.gif'].contains(fileExtension)) {
            fileType = 'image';
          } else if (['.mp4', '.mov', '.avi', 'mkv'].contains(fileExtension)) {
            fileType = 'video';
          } else {
            fileType = 'document';
          }

          final storageRef = FirebaseStorage.instance.ref();
          final fileRef =
              storageRef.child('chat_files/${msgRef.id}$fileExtension');

          // Upload the file to Firebase Storage
          await fileRef.putFile(selectedFile.value);

          // Get the download URL of the uploaded file
          final fileUrl = await fileRef.getDownloadURL();

          // Update the message with the file URL and correct type
          await msgRef.update(
            {
              'imageUrl': fileUrl,
              'type': fileType,
            },
          );
          selectedFile.value = File('');
        }

        // Clear the text controller
        msgController.clear();
      } catch (e) {
        print('Error sending message: $e');
        // Optionally, show an error message to the user.
      } finally {
        updatePageState(PageState.DEFAULT);
      }
    }
  }

  Future<void> addFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov', 'avi', 'mkv'],
    );

    if (result != null) {
      final File file = File(result.files.single.path!);
      selectedFile.value = file;
    } else {
      logger.i('User canceled the picker');
      // User canceled the picker
    }
  }

  //open camera to take a picture and video
  Future<void> openCamera() async {
    Get.toNamed(
      Routes.CAMERA,
    )?.then(
      (value) {
        print('i am getting image');
        if (value != null) {
          selectedFile.value = value as File;
        }
      },
    );
  }
}
