import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/base/base_view.dart';
import '/app/core/values/app_colors.dart';
import '/app/core/widget/text_form_field_widget.dart';
import 'add_chat_modal_controller.dart';

class AddChatModalView extends BaseView<AddChatModalController> {
  AddChatModalView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: Get.back,
      ),
      title: const Text('Add A New User'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
                TextFormFieldWidget(
                  controller: controller.nameController,
                  hintText: 'Name',
                  validator: requiredValidator,
                ),
                TextFormFieldWidget(
                  controller: controller.phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: phoneValidator,
                ),
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
                Obx(
                  () {
                    return controller.profilePic.value.path.isNotEmpty
                        ? Image.file(
                            controller.profilePic.value,
                            height: 100,
                            width: 100,
                          )
                        : Container();
                  },
                ),
                10.height,
                ElevatedButton(
                  onPressed: controller.pickProfilePic,
                  child: const Text(
                    'Pick Profile Pic',
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.register,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
