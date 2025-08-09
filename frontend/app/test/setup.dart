import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> setupFirebaseForTesting() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    // Configure Firebase Auth to use emulator
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

    // Firebase Auth emulator configured successfully
  } catch (e) {
    // Firebase initialization may fail in test environment
    // This is expected and tests can still run for non-Firebase dependent code
    // Firebase initialization skipped in test environment: $e
  }
}
