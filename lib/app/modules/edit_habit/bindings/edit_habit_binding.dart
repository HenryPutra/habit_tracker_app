import 'package:get/get.dart';

import '../controllers/edit_habit_controller.dart';

class EditHabitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditHabitController>(
      () => EditHabitController(),
    );
  }
}
