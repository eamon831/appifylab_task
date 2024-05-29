import 'dart:io';

import 'package:appifylab_task/app/core/model/page_state.dart';
import 'package:appifylab_task/app/model/receiver_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';

class SettingsController extends BaseController {
  final selectedProfileImage = File('').obs;
  final myUserObj = Rx<ReceiverUser?>(null);
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      myUserObj.value = args['user'];
    }
  }

  Future<void> changeProfileImage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty && myUserObj.value != null) {
      updatePageState(PageState.LOADING);
      final File file = File(result.files.single.path!);
      selectedProfileImage.value = file;
      final storageRef = FirebaseStorage.instance.ref(
        'profile_pics/${myUserObj.value!.uid}',
      );
      //update the profile pic in firestore
      await storageRef.putFile(file).whenComplete(() => null);

      //update the profile pic in the user object on firestore
      final userRef = FirebaseFirestore.instance.collection(tblUsers).doc(
            myUserObj.value!.uid,
          );
      await userRef.update(
        {
          'photo_url': await storageRef.getDownloadURL(),
        },
      );
      myUserObj.value!.photoUrl = await storageRef.getDownloadURL();
      myUserObj.refresh();
      updatePageState(PageState.DEFAULT);
    } else {
      logger.i('User canceled the picker');
      // User canceled the picker
    }
  }
}
