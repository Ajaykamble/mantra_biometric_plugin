import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mantra_biometric_platform_interface.dart';

/// An implementation of [MantraBiometricPlatform] that uses method channels.
class MethodChannelMantraBiometric extends MantraBiometricPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mantra_biometric');

  @override
  Future<String?> captureFingurePrint(String pidOptions) async {
    final result = await methodChannel.invokeMethod<String>('capture',{"pidOptions":pidOptions});
    return result;
  }
  @override
  Future<Map<String,dynamic>?> getDeviceInfo() async {
    final result = await methodChannel.invokeMethod<Map<String,dynamic>>('getDeviceInfo');
    return result;
  }
}