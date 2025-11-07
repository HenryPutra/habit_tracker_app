import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/app/modules/progress/views/progress_view.dart';
import 'package:habit_tracker_app/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../../models/habit_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  final Color primaryColor = const Color(0xFF5E35B1);
  final Color newBackgroundColor = const Color(0xFFF0F0F5);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null && Get.arguments is String) {
        controller.username.value = Get.arguments as String;
      }
    });

    if (controller.isNull) {
      Get.put(HomeController());
    }

    return Scaffold(
      backgroundColor: newBackgroundColor,

      body: Obx(() => _buildBodyContent(context)),

      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_HABIT);
        },
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHabitContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            _buildHeader(context),

            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                _buildHabitList(),
                const SizedBox(height: 80),
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    switch (controller.selectedIndex.value) {
      case 0:
        return _buildHabitContent(context);
      case 2:
        return const ProgressView();
      default:
        return Center(
          child: Text(
            'Halaman Index ${controller.selectedIndex.value} Belum Tersedia',
          ),
        );
    }
  }

  Widget _buildHeader(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 170.0,
      pinned: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.zero,
        background: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 50,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'Hai, ${controller.username.value}!',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' 👋'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: controller.showLogoutDialog,
                    child: const Icon(Icons.logout, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              const Text(
                'Mari bangun kebiasaan baik hari ini',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 25),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Progress Bar Horizontal
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: controller.progressPercentage,
                          backgroundColor: Colors.grey.withValues(alpha: 0.5),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      '${controller.completedHabits} dari ${controller.totalHabits} kebiasaan selesai (${(controller.progressPercentage * 100).toStringAsFixed(0)}%)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.habits.length,
          itemBuilder: (context, index) {
            final habit = controller.habits[index];
            return _buildHabitItem(habit);
          },
        ),
      ),
    );
  }

  Widget _buildHabitItem(HabitModel habit) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => controller.toggleHabitCompletion(habit.id),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(habit.iconData, color: habit.iconColor, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  habit.title,
                  style: TextStyle(
                    fontSize: 18,
                    decoration: habit.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: habit.isCompleted ? Colors.grey : Colors.black87,
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.editHabit(habit),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit_outlined,
                    color: primaryColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.deleteHabit(habit.id),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.delete_outline, color: Colors.red.shade400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Obx(
      () => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: _buildNavItem(
                  0,
                  Icons.check_circle_outline,
                  'Habit',
                  controller.selectedIndex.value == 0,
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: _buildNavItem(
                  2,
                  Icons.trending_up,
                  'Progress',
                  controller.selectedIndex.value == 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () => controller.changeTabIndex(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: isSelected ? primaryColor : Colors.grey),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? primaryColor : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
