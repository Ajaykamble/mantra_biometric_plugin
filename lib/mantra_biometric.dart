import 'package:flutter/services.dart';
import 'package:mantra_biometric/utils/app_exception.dart';

import 'mantra_biometric_platform_interface.dart';

class MantraBiometric {
  Future<String?> captureFingurePrint({required String pidOptions}) async {
    try {
      return await MantraBiometricPlatform.instance.captureFingurePrint(pidOptions);
    } on PlatformException catch (e) {
      String? code = e.code;
      String? message = e.message;
      String? details = e.details;
      switch (e.code) {
        case "ClientNotFound":
          throw ClientNotFound(code, message, details);
          break;
        default:
          rethrow;
          break;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getDeviceInformation() async {
    try {
      return await MantraBiometricPlatform.instance.getDeviceInfo();
    } on PlatformException catch (e) {
      String? code = e.code;
      String? message = e.message;
      String? details = e.details;
      switch (e.code) {
        case "ClientNotFound":
          throw ClientNotFound(code, message, details);
          break;
        default:
          rethrow;
          break;
      }
    } catch (e) {
      rethrow;
    }
  }
}
