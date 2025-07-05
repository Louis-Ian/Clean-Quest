import 'package:app/core/theme/app_buttons.dart';
import 'package:app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: onPressed != null ? AppButtons.primary : AppButtons.disabled,
      onPressed: onPressed,
      child: Text(text, style: AppTextStyles.button),
    );
  }
}
