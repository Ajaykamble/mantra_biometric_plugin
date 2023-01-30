
import 'mantra_biometric_platform_interface.dart';

class MantraBiometric {
  Future<String?> getPlatformVersion() {
    return MantraBiometricPlatform.instance.getPlatformVersion();
  }
}
