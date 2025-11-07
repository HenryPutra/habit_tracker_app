import 'package:get/get.dart';

import '../modules/add_habit/bindings/add_habit_binding.dart';
import '../modules/add_habit/views/add_habit_view.dart';
import '../modules/edit_habit/bindings/edit_habit_binding.dart';
import '../modules/edit_habit/views/edit_habit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/progress/bindings/progress_binding.dart';
import '../modules/progress/views/progress_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_HABIT,
      page: () => const AddHabitView(),
      binding: AddHabitBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.EDIT_HABIT,
      page: () => const EditHabitView(),
      binding: EditHabitBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS,
      page: () => const ProgressView(),
      binding: ProgressBinding(),
    ),
  ];
}
