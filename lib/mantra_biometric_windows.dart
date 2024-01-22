import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'mantra_biometric_platform_interface.dart';

class MantraBiometricWindows extends MantraBiometricPlatform {
  MantraBiometricWindows();

  static void registerWith(Registrar registrar) {
    MantraBiometricPlatform.instance = MantraBiometricWindows();
  }
}
