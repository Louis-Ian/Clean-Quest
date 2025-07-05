import 'package:app/core/theme/app_text_styles.dart';
import 'package:app/features/welcome/viewmodel/welcome_viewmodel.dart';
import 'package:app/shared/widgets/primary_button.dart';
import 'package:app/shared/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(welcomeViewModelProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Image.asset(
                'assets/images/cleanquest_welcome.png',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Welcome to CleanQuest!',
                      style: AppTextStyles.headline,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Transform chores into an exciting adventure. '
                      'Create or join a family to begin your quest.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        onPressed: () {
                          viewModel.createFamily();
                        },
                        text: 'Create a Family',
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: SecondaryButton(
                        onPressed: () {
                          viewModel.joinFamily();
                        },
                        text: 'Join a Family',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'By proceeding, you consent to our Terms of Service and Privacy Policy.',
                      style: AppTextStyles.bodyMuted,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
