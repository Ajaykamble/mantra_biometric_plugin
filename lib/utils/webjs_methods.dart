@JS()
library mantra;

import 'package:js/js.dart';
import 'dart:async';

@JS()
external Future<dynamic> jsgetDeviceInfo(port);

@JS()
external Future<dynamic> jscaptureFingerPrint(pidOptions,port);