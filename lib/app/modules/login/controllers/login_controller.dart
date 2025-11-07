import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();

  void handleLogin() {
    String username = usernameController.text.trim();
    if (username.isNotEmpty) {
      Get.snackbar('Berhasil!', 'Mencoba masuk dengan username: $username');

      Get.offAllNamed(Routes.HOME, arguments: username);
    } else {
      Get.snackbar(
        'Peringatan',
        'Username tidak boleh kosong!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }
}
