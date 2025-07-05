import 'package:app/core/theme/app_buttons.dart';
import 'package:app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SecondaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: onPressed != null ? AppButtons.secondary : AppButtons.disabled,
      onPressed: onPressed,
      child: Text(text, style: AppTextStyles.button),
    );
  }
}
