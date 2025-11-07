import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/app/routes/app_pages.dart';
import '../../../../models/habit_model.dart';

class HomeController extends GetxController {
  final RxString username = 'Pengguna'.obs;
  final RxList<HabitModel> habits = <HabitModel>[
    HabitModel(
      id: '1',
      title: 'Bangun Pagi',
      iconData: Icons.wb_sunny_outlined,
      iconColor: Colors.orange.shade400,
      isCompleted: false,
    ),
    HabitModel(
      id: '2',
      title: 'Olahraga',
      iconData: Icons.directions_run_outlined,
      iconColor: Colors.amber.shade700,
      isCompleted: false,
    ),
    HabitModel(
      id: '3',
      title: 'Baca Buku',
      iconData: Icons.menu_book_outlined,
      iconColor: Colors.green.shade600,
      isCompleted: false,
    ),
  ].obs;

  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(selectedIndex, (_) {});

    Future.delayed(const Duration(milliseconds: 100), () {
      _checkArguments();
    });
  }

  @override
  void onReady() {
    super.onReady();
    _checkArguments();
  }

  void _checkArguments() {
    try {
      if (Get.arguments != null) {
        if (Get.arguments is String) {
          username.value = Get.arguments as String;
        } else {
          print('Arguments type: ${Get.arguments.runtimeType}');
          print('Arguments value: $Get.arguments');
        }
      }
    } catch (e) {
      print('Error checking arguments: $e');
    }
  }

  void addHabit(HabitModel newHabit) {
    habits.add(newHabit);
  }

  void updateHabit(HabitModel updatedHabit) {
    final index = habits.indexWhere((h) => h.id == updatedHabit.id);
    if (index != -1) {
      habits[index] = updatedHabit;
    }
  }

  int get totalHabits => habits.length;
  int get completedHabits => habits.where((h) => h.isCompleted).length;
  double get progressPercentage {
    if (totalHabits == 0) return 0.0;
    return completedHabits / totalHabits;
  }

  void toggleHabitCompletion(String id) {
    int index = habits.indexWhere((h) => h.id == id);
    if (index != -1) {
      habits[index] = habits[index].copyWith(
        isCompleted: !habits[index].isCompleted,
      );
    }
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void editHabit(HabitModel habit) {
    Get.toNamed(Routes.EDIT_HABIT, arguments: habit);
    Get.snackbar('Edit', 'Mengedit kebiasaan: ${habit.title}');
  }

  void deleteHabit(String id) {
    Get.snackbar(
      'Hapus',
      'Kebiasaan berhasil dihapus!',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    habits.removeWhere((h) => h.id == id);
  }

  void showLogoutDialog() {
    final Color primaryColor = Get.theme.primaryColor;

    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin keluar dari aplikasi?",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: const TextStyle(color: Colors.black87),
      radius: 10.0,
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          handleLogout();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text("Ya"),
      ),
      cancel: OutlinedButton(
        onPressed: () {
          Get.back();
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text("Tidak"),
      ),
    );
  }

  void handleLogout() {
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar(
      "Selesai",
      "Anda berhasil keluar.",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
