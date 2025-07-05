import 'package:app/features/auth/provider/auth_provider.dart';
import 'package:app/features/welcome/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CleanQuestApp extends ConsumerWidget {
  const CleanQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'CleanQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        useMaterial3: true,
      ),
      home: authState.when(
        data: (user) {
          if (user != null) {
            return const WelcomeScreen(key: Key('welcome_screen'));
          } else {
            return const WelcomeScreen(key: Key('welcome_screen'));
          }
        },
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const Text("Something went wrong"),
      ),
    );
  }
}
