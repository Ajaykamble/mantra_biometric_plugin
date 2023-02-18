// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/services.dart';
import 'package:mantra_biometric/utils/mantra_plugin_exception.dart';
import 'package:xml/xml.dart';
import 'package:collection/collection.dart';
import 'mantra_biometric_platform_interface.dart';

class MantraBiometric {
  Future<String?> captureFingerPrint({required String pidOptions}) async {
    try {
      String? result =
          await MantraBiometricPlatform.instance.captureFingerPrint(pidOptions);
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
    } on PlatformException catch (e) {
      String? code = e.code;
      String? message = e.message;
      String? details = e.details;
      switch (e.code) {
        case "ClientNotFound":
          throw RDClientNotFound(code, message, details);
        default:
          rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getDeviceInformation() async {
    try {
      String? result = await MantraBiometricPlatform.instance.getDeviceInfo();
      return result;
    } on PlatformException catch (e) {
      String? code = e.code;
      String? message = e.message;
      String? details = e.details;
      switch (e.code) {
        case "ClientNotFound":
          throw RDClientNotFound(code, message, details);
        default:
          rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
