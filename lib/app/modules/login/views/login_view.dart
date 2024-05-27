import 'package:appifylab_task/app/core/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/base/base_view.dart';
import '/app/modules/login/controllers/login_controller.dart';

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
                validator: emailValidator,
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
                    validator: passwordValidator,
                    obscureText: !controller.showPassword.value,
                  );
                },
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: controller.login,
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: controller.register,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
