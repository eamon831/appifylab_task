import 'package:appifylab_task/app/core/widget/elevated_container.dart';
import 'package:appifylab_task/app/core/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

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
        child: Form(
          key: controller.formKey,
          child: Column(
            children: <Widget>[
              TextFormFieldWidget(
                controller: controller.emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              Obx(
                () {
                  return TextFormFieldWidget(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    suffix: IconButton(
                      icon: Icon(
                        controller.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.showPassword.toggle,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    obscureText: !controller.showPassword.value,
                  );
                },
              ),
              ElevatedContainer(
                onPressed: () {
                  toast('Forgot Password?');
                },
                bgColor: Colors.transparent,
                padding: const EdgeInsets.all(8),
                borderRadius: 0,
                child: const Text('Forgot Password?'),
              ),
              ElevatedButton(
                onPressed: controller.login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
