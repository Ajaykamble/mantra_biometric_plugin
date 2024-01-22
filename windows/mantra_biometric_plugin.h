#ifndef FLUTTER_PLUGIN_MANTRA_BIOMETRIC_PLUGIN_H_
#define FLUTTER_PLUGIN_MANTRA_BIOMETRIC_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace mantra_biometric {

class MantraBiometricPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MantraBiometricPlugin();

  virtual ~MantraBiometricPlugin();

  // Disallow copy and assign.
  MantraBiometricPlugin(const MantraBiometricPlugin&) = delete;
  MantraBiometricPlugin& operator=(const MantraBiometricPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace mantra_biometric

#endif  // FLUTTER_PLUGIN_MANTRA_BIOMETRIC_PLUGIN_H_
