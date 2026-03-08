import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppGradients {
  static const LinearGradient cyanGreen = LinearGradient(
    colors: [AppColors.cyan, AppColors.green],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
