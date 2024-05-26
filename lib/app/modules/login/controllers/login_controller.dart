import 'package:appifylab_task/app/core/model/page_state.dart';
import 'package:appifylab_task/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '/app/core/base/base_controller.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final showPassword = false.obs;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    updatePageState(PageState.LOADING);

    final email = emailController.text;
    final password = passwordController.text;

    try {
      final userCredential = await _signInWithEmailAndPassword(
        email,
        password,
      );
      _logSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } finally {
      updatePageState(PageState.DEFAULT);
    }
  }

  Future<UserCredential> _signInWithEmailAndPassword(
    String email,
    String password,
  ) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void _logSuccess(UserCredential userCredential) {
    final uid = userCredential.user?.uid;
    final userEmail = userCredential.user?.email;
    if (uid != null && userEmail != null) {
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
}
