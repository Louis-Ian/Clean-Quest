import 'package:app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'app_text_styles.dart';

class AppButtons {
  static final primary = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppColors.buttonPrimary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    textStyle: AppTextStyles.button.copyWith(color: Colors.white),
  );

  static final secondary = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppColors.buttonSecondary,
    foregroundColor: AppColors.textPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    textStyle: AppTextStyles.button,
  );

  static final disabled = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppColors.buttonDisabled,
    foregroundColor: AppColors.textDisabled,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    textStyle: AppTextStyles.button.copyWith(color: AppColors.textDisabled),
  );
}
