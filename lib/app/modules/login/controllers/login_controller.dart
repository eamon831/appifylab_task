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
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
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
    if (uid != null) {
      toast('Logged in as: $userEmail');
    }
  }

  void _handleFirebaseAuthException(FirebaseAuthException e) {
    logger.e('FirebaseAuthException: ${e.message}', error: e);
    toast(e.message);
  }

  void _logGeneralException(Exception e) {
    logger.e('An unexpected error occurred: $e');
  }
}
