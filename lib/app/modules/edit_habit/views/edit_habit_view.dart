import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_habit_controller.dart';

class EditHabitView extends GetView<EditHabitController> {
  const EditHabitView({super.key});

  final Color primaryColor = const Color(0xFF5E35B1);
  final Color newBackgroundColor = const Color(0xFFF0F0F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: newBackgroundColor,

      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 80,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: _buildMainCard(),
            ),
          ),

          Positioned(
            top: 40,
            left: 10,
            child: TextButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black54,
                size: 20,
              ),
              label: const Text(
                'Kembali',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    return Card(
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Kebiasaan Baru',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Nama Kebiasaan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: TextField(
                controller: controller.nameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Contoh: Meditasi 10 menit',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Pilih Icon',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            _buildIconSelectionGrid(),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: controller.saveHabit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelectionGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemCount: controller.availableIcons.length,
      itemBuilder: (context, index) {
        final iconData = controller.availableIcons[index];

        return Obx(() {
          final isSelected = controller.selectedIconIndex.value == index;

          return InkWell(
            onTap: () {
              if (Get.isRegistered<EditHabitController>()) {
                controller.selectIcon(index);
              }
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? controller.primaryColor
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
                border: isSelected
                    ? Border.all(color: controller.primaryColor, width: 2)
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: controller.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                iconData.icon,
                color: isSelected ? Colors.white : iconData.color,
                size: 28,
              ),
            ),
          );
        });
      },
    );
  }
}
