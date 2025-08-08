import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'package:window_size/window_size.dart' as window_size;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set a smartphone-like window size when running on desktop
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    const ui.Size phoneLikeSize = ui.Size(390, 844); // ~iPhone 12 logical size
    // Position slightly offset from top-left
    final ui.Rect frame = ui.Rect.fromLTWH(100, 100, phoneLikeSize.width, phoneLikeSize.height);
    window_size.setWindowTitle('CleanQuest');
    window_size.setWindowMinSize(phoneLikeSize);
    window_size.setWindowMaxSize(phoneLikeSize);
    window_size.setWindowFrame(frame);
  }

  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const ProviderScope(child: CleanQuestApp()));
}
