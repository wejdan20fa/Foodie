// Public-source placeholder. Generate project-specific settings with:
//   dart pub global activate flutterfire_cli
//   flutterfire configure
// This file is overwritten by FlutterFire CLI for your own Firebase project.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnsupportedError(
      'Firebase is not configured. Run flutterfire configure using your own project.',
    );
  }
}
