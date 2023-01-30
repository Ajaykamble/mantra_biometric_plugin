import 'package:flutter_test/flutter_test.dart';
import 'package:mantra_biometric/mantra_biometric.dart';
import 'package:mantra_biometric/mantra_biometric_platform_interface.dart';
import 'package:mantra_biometric/mantra_biometric_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMantraBiometricPlatform
    with MockPlatformInterfaceMixin
    implements MantraBiometricPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MantraBiometricPlatform initialPlatform = MantraBiometricPlatform.instance;

  test('$MethodChannelMantraBiometric is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMantraBiometric>());
  });

  test('getPlatformVersion', () async {
    MantraBiometric mantraBiometricPlugin = MantraBiometric();
    MockMantraBiometricPlatform fakePlatform = MockMantraBiometricPlatform();
    MantraBiometricPlatform.instance = fakePlatform;

    expect(await mantraBiometricPlugin.getPlatformVersion(), '42');
  });
}
