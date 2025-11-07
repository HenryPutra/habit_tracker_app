import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/app/modules/home/controllers/home_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressView extends GetView<HomeController> {
  const ProgressView({super.key});

  final Color primaryColor = const Color(0xFF5E35B1);
  final Color newBackgroundColor = const Color(0xFFF0F0F5);
  final Color completeColor = const Color(0xFF4CAF50);
  final Color remainingColor = const Color(0xFFF44336);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: newBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressHeader(),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                final progress = controller.progressPercentage;
                final completed = controller.completedHabits;
                final total = controller.totalHabits;
                final remaining = total - completed;

                return Column(
                  children: [
                    _buildCircularProgressCard(progress, completed, total),

                    const SizedBox(height: 20),

                    _buildSummaryCards(completed, remaining),

                    const SizedBox(height: 20),

                    _buildMotivationCard(progress),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Hari Ini',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Pantau pencapaianmu',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgressCard(double progress, int completed, int total) {
    String percentage = (progress * 100).toStringAsFixed(0);

    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 15.0,
                percent: progress,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                    const Text(
                      'Selesai',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ],
                ),
                progressColor: primaryColor,
                backgroundColor: Colors.grey.shade200,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 15),
              Text(
                '$completed dari $total kebiasaan',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(int completed, int remaining) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryItem(
            'Selesai',
            completed.toString(),
            completeColor,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildSummaryItem(
            'Tersisa',
            remaining.toString(),
            remainingColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationCard(double progress) {
    String message;
    String subtitle;
    IconData icon;
    Color textColor;
    Color iconColor;
    Color bgColor = Colors.white;

    if (progress >= 1.0) {
      message = 'Luar biasa! Semua kebiasaan selesai!';
      subtitle = 'Kamu mencapai 100% target hari ini. Pertahankan momentum!';
      icon = Icons.emoji_events;
      textColor = primaryColor;
      iconColor = primaryColor;
    } else {
      message = 'Ayo semangat! Kamu pasti bisa!';
      subtitle = 'Konsistensi adalah kunci kesuksesan, selesaikan sisanya.';
      icon = Icons.rocket_launch;
      textColor = Colors.black87;
      iconColor = primaryColor;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 10),
              Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
