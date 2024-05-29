import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/modules/register/controllers/register_controller.dart';

class AddChatModalController extends RegisterController {
  @override
  Future<void> logSuccess(UserCredential userCredential) async {
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
      Get.back();
    } else {
      toast('An error occurred. Please try again later');
    }
  }
}
