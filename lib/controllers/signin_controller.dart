import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;
  late TextEditingController confirmPassC;

  @override
  void onInit() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    confirmPassC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    confirmPassC.dispose();
    super.onClose();
  }
}
