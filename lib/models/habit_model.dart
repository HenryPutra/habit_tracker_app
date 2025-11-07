// lib/models/habit_model.dart atau app/data/models/habit_model.dart

import 'package:flutter/widgets.dart';

class HabitModel {
  final String id;
  final String title;
  final IconData iconData;
  final Color iconColor;
  final bool isCompleted;

  HabitModel({
    required this.id,
    required this.title,
    required this.iconData,
    required this.iconColor,
    this.isCompleted = false,
  });

  HabitModel copyWith({
    String? id,
    String? title,
    IconData? iconData,
    Color? iconColor,
    bool? isCompleted,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      iconData: iconData ?? this.iconData,
      iconColor: iconColor ?? this.iconColor,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
