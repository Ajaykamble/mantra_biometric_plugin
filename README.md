# mantra_biometric


[![pub package](https://img.shields.io/pub/v/mantra_biometric.svg)](https://pub.dev/packages/mantra_biometric)

**_NOTE:_**  we have tested this plugin with [Mantra MFS100-Fingerprint-Sensor](https://www.mantratec.com/products/Fingerprint-Sensors/MFS100-Fingerprint-Scanner).

A Flutter plugin to enable the biometric based aadhaar authentication with registered device concept implemented by UIDAI.
Supports Android,Web,Windows.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :----: |
|   ✔️    | ❌  |  ❌   | ❌  |  ❌   |   ❌   |

# Prerequisite

### INSTALLATION OF MANTRA MFS 100 driver and RD Service
#### Android
* Download [Mantra RD Service application](https://play.google.com/store/apps/details?id=com.mantra.rdservice&hl=en_IN&gl=US) from playstore.

#### Web, Windows
* [Download RD service](https://download.mantratecapp.com/StaticDownload/MantraRDService_1.0.8.exe)
* [Download Windows Driver](https://download.mantratecapp.com/StaticDownload/MFS100Driver_9.2.0.0.exe)

    Run both exe files downloaded

### CONNECTING MANTRA MFS 100 to Computer
* Plug in the Biometric device
* On first time initialization bottom right prompt will instruct to unplug and replug the device
* After connecting the USB connector for `Biometric device attached` prompt is seen on bottom right of the screen
* After successful connection to server `Framework ready` to use prompt shows up

# Usage
* To use this plugin, add `mantra_biometric` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Example
```dart
// Import package
import 'package:mantra_biometric/mantra_biometric.dart';

// Instantiate Object
final _mantraBiometricPlugin = MantraBiometric();

// To get device Information call following method
String output = await _mantraBiometricPlugin.getDeviceInformation() ?? "";

// To scan fingerprint call following method
/// `captureFingerPrint` method required pidOptions as paramter
// 
String wadh = "";
String pidOptions ="<PidOptions ver=\"1.0\"> <Opts fCount=\"1\" fType=\"2\" pCount=\"0\" format=\"0\" pidVer=\"2.0\" wadh=\"$wadh\" timeout=\"20000\"  posh=\"UNKNOWN\" env=\"P\" /> </PidOptions>";
String result = await _mantraBiometricPlugin.captureFingerPrint(pidOptions: pidOptions) ?? "";

```

### Exceptions
```dart 
    import 'package:mantra_biometric/utils/mantra_plugin_exception.dart';
```
* RDClientNotFound
    
    Throws if RD Services Client is not installed on device/computer
* RDException
    
    Throws if you have pass wrong pidOptions parameter to `captureFingerPrint` Method.

## Api Documentation
- [RD Service APIs](https://uidai.gov.in/images/resource/aadhaar_registered_devices_2_0_2_18072017.pdf)