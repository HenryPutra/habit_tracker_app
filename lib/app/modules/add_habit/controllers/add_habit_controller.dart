import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/app/modules/home/controllers/home_controller.dart';
import 'package:habit_tracker_app/models/icon_data_model.dart';
import '../../../../models/habit_model.dart';

class AddHabitController extends GetxController {
  final nameController = TextEditingController();
  final RxInt selectedIconIndex = (-1).obs;

  final List<IconDataModel> availableIcons = [
    IconDataModel(icon: Icons.auto_awesome, color: Colors.amber.shade400),
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

  Color get primaryColor => Colors.blue;

  void selectIcon(int index) {
    selectedIconIndex.value = index;
  }

  Future<void> addHabit() async {
    String habitName = nameController.text.trim();

    if (habitName.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama kebiasaan tidak boleh kosong.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedIconIndex.value == -1) {
      Get.snackbar(
        'Error',
        'Silakan pilih ikon untuk kebiasaan Anda.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final selectedIcon = availableIcons[selectedIconIndex.value];
    final newHabit = HabitModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: habitName,
      iconData: selectedIcon.icon,
      iconColor: selectedIcon.color,
      isCompleted: false,
    );

    final homeController = Get.find<HomeController>();
    homeController.addHabit(newHabit);

    Get.snackbar(
      'Berhasil!',
      'Kebiasaan "$habitName" ditambahkan.',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1800),
      margin: const EdgeInsets.all(10),
    );

    await Future.delayed(const Duration(milliseconds: 2000));

    Get.back();
  }
}
