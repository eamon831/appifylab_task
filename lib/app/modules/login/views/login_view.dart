import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends BaseView<LoginController> {
  LoginView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: const Text('Login'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextFormField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: controller.login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
