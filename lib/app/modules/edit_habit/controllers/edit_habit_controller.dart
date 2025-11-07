import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/habit_model.dart';
import '../../../../models/icon_data_model.dart';
import '../../home/controllers/home_controller.dart';

class EditHabitController extends GetxController {
  late final HabitModel originalHabit;

  final TextEditingController nameController = TextEditingController();
  final RxInt selectedIconIndex = (-1).obs;

  final Color primaryColor = const Color(0xFF5E35B1);

  final List<IconDataModel> availableIcons = [
    IconDataModel(icon: Icons.star, color: Colors.yellow),
    IconDataModel(icon: Icons.book_online, color: Colors.deepOrange.shade400),
    IconDataModel(icon: Icons.fitness_center, color: Colors.amber.shade700),
    IconDataModel(icon: Icons.menu_book, color: Colors.green.shade600),
    IconDataModel(icon: Icons.self_improvement, color: Colors.orange.shade300),
    IconDataModel(icon: Icons.water_drop, color: Colors.blue.shade400),
    IconDataModel(icon: Icons.local_dining, color: Colors.green.shade700),
    IconDataModel(icon: Icons.sentiment_satisfied_alt, color: Colors.orange),
    IconDataModel(icon: Icons.ads_click, color: Colors.red.shade400),
    IconDataModel(icon: Icons.color_lens, color: Colors.pink.shade300),
    IconDataModel(icon: Icons.brush, color: Colors.orange.shade500),
    IconDataModel(icon: Icons.directions_run, color: Colors.blue.shade600),
  ];

  @override
  void onInit() {
    if (Get.arguments is HabitModel) {
      originalHabit = Get.arguments as HabitModel;

      nameController.text = originalHabit.title;

      int index = availableIcons.indexWhere(
        (iconModel) => iconModel.icon == originalHabit.iconData,
      );

      selectedIconIndex.value = index != -1 ? index : 0;
    } else {
      Get.back();
    }
    super.onInit();
  }

  void selectIcon(int index) {
    selectedIconIndex.value = index;
  }

  Future<void> saveHabit() async {
    String newHabitName = nameController.text.trim();

    if (newHabitName.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama kebiasaan tidak boleh kosong.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    IconDataModel selectedIcon = availableIcons[selectedIconIndex.value];

    HabitModel updatedHabit = originalHabit.copyWith(
      title: newHabitName,
      iconData: selectedIcon.icon,
      iconColor: selectedIcon.color,
    );

    final homeController = Get.find<HomeController>();
    homeController.updateHabit(updatedHabit);

    Get.snackbar(
      'Berhasil!',
      'Kebiasaan "${newHabitName}" diperbarui.',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1800),
      margin: const EdgeInsets.all(10),
    );

    await Future.delayed(const Duration(milliseconds: 2000));
    Get.back();
  }
}
