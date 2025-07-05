import 'package:app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(fontSize: 16, color: AppColors.textSecondary);

  static const bodyMuted = TextStyle(fontSize: 16, color: AppColors.textPrimaryMuted);

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const smallCaption = TextStyle(fontSize: 12, color: AppColors.textSecondary);
}
