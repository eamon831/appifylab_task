import 'dart:io';

import 'package:appifylab_task/app/core/model/page_state.dart';
import 'package:appifylab_task/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '/app/core/base/base_controller.dart';

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController(
    text: 'test@gmail.com',
  );
  final passwordController = TextEditingController(
    text: '123456',
  );
  final profilePic = File('').obs;
  final showPassword = false.obs;

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;
    if (profilePic.value.path.isEmpty) {
      toast('Please select a profile picture');
      return;
    }

    updatePageState(PageState.LOADING);

    final email = emailController.text;
    final password = passwordController.text;

    try {
      final userCredential = await _registerWithEmailAndPassword(
        email,
        password,
      );
      await _logSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } finally {
      updatePageState(PageState.DEFAULT);
    }
  }

  Future<UserCredential> _registerWithEmailAndPassword(
    String email,
    String password,
  ) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> _logSuccess(UserCredential userCredential) async {
    final uid = userCredential.user?.uid;
    final userEmail = userCredential.user?.email;
    final name = nameController.text;
    final phone = phoneController.text;
    if (uid != null && userEmail != null) {
      await addUserToFirestore(
        userCredential.user!,
        name,
        phone,
      );
      toast('Logged in as: $userEmail');
      Get.offAllNamed(Routes.MAIN);
    } else {
      toast('Login successful, but user details are incomplete.');
    }
  }

  void _handleFirebaseAuthException(FirebaseAuthException e) {
    logger.e('FirebaseAuthException: ${e.message}', error: e);
    toast(e.message ?? 'An error occurred. Please try again.');
  }

  Future<void> addUserToFirestore(
    User user,
    String name,
    String phone,
  ) async {
    final users = FirebaseFirestore.instance.collection(tblUsers);
    final storageRef = FirebaseStorage.instance.ref();
    final profilePicRef = storageRef.child('profile_pics/${user.uid}');
    await profilePicRef.putFile(profilePic.value).whenComplete(() => null);

    await users.doc(user.uid).set(
      {
        'uid': user.uid,
        'email': user.email,
        'name': name,
        'phone': phone,
        'photo_url': await profilePicRef.getDownloadURL(),
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> pickProfilePic() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final File file = File(result.files.single.path!);
      profilePic.value = file;
    } else {
      logger.i('User canceled the picker');
      // User canceled the picker
    }
  }
}
