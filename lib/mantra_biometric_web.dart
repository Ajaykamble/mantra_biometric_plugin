// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
//import 'dart:html' as html show window;

// ignore_for_file: non_constant_identifier_names

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js_util.dart';
import 'package:mantra_biometric/utils/mantra_plugin_exception.dart';
import 'package:mantra_biometric/utils/webjs_methods.dart';
import 'package:xml/xml.dart';

import 'mantra_biometric_platform_interface.dart';
import 'package:collection/collection.dart';

/// A web implementation of the MantraBiometricPlatform of the MantraBiometric plugin.
class MantraBiometricWeb extends MantraBiometricPlatform {
  /// Constructs a MantraBiometricWeb
  MantraBiometricWeb();

  static void registerWith(Registrar registrar) {
    MantraBiometricPlatform.instance = MantraBiometricWeb();
  }

  int BASE_PORT=11100;

  @override
  Future<String?> captureFingerPrint(String pidOptions) async {
    try {
      String? result = await promiseToFuture(jscaptureFingerPrint(pidOptions,BASE_PORT));
      if (result != null && result.isNotEmpty) {
        final xmlDocument = XmlDocument.parse(result);
        XmlElement? errorField = xmlDocument
            .findElements("PidData")
            .firstOrNull
            ?.findElements("Resp")
            .firstOrNull;
        if (errorField != null) {
          String? errorCode = errorField.attributes
                  .firstWhereOrNull(
                      (element) => element.name.toString() == "errCode")
                  ?.value ??
              "";
          String? errorInfo = errorField.attributes
                  .firstWhereOrNull(
                      (element) => element.name.toString() == "errInfo")
                  ?.value ??
              "";
          if (errorCode == "0") {
            return result;
          } else {
            throw RDException(errorCode, "Something Went Wrong", errorInfo);
          }
        }
        throw RDException(
            "503", "Something Went Wrong", "Unable to Prarse Result");
      } else {
        throw RDException("503", "Something Went Wrong", "Result got null");
      }
    } catch (e) {
      if(e=="ClientNotFound")
      {
        throw RDClientNotFound("ClientNotFound","Service Not Running","Install Client Application");
      }
      rethrow;
    }
  }

  @override
  Future<String?> getDeviceInfo() async {
    try {
      String? result = await promiseToFuture(jsgetDeviceInfo(BASE_PORT));
      return result;
    } catch (e) {
      if(e=="ClientNotFound")
      {
        throw RDClientNotFound("ClientNotFound","Service Not Running","Install Client Application");
      }
      rethrow;
    }
  }
}
