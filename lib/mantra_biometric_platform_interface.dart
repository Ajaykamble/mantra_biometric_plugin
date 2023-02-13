import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mantra_biometric_method_channel.dart';

abstract class MantraBiometricPlatform extends PlatformInterface {
  /// Constructs a MantraBiometricPlatform.
  MantraBiometricPlatform() : super(token: _token);

  static final Object _token = Object();

  static MantraBiometricPlatform _instance = MethodChannelMantraBiometric();

  /// The default instance of [MantraBiometricPlatform] to use.
  ///
  /// Defaults to [MethodChannelMantraBiometric].
  static MantraBiometricPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MantraBiometricPlatform] when
  /// they register themselves.
  static set instance(MantraBiometricPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> captureFingerPrint(String pidOptions){
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> getDeviceInfo(){
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
