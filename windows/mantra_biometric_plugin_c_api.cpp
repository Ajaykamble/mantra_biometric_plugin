#include "include/mantra_biometric/mantra_biometric_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "mantra_biometric_plugin.h"

void MantraBiometricPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  mantra_biometric::MantraBiometricPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
