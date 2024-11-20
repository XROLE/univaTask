import 'dart:math';

import 'package:flutter/material.dart';
import 'package:univa_task/utils/app_colors.dart';

class Helper {
  Color getRandomColor() {
    final random = Random();
    List<Color> colors = [AppColors.secondary, AppColors.blue, AppColors.primary, AppColors.green];
    int index = random.nextInt(4);
    return colors[index];
  }
}
