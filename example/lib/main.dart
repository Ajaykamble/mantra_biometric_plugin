import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:mantra_biometric/mantra_biometric.dart';
import 'package:mantra_biometric/utils/mantra_plugin_exception.dart';
import 'package:xml/xml.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mantraBiometricPlugin = MantraBiometric();

  @override
  void initState() {
    super.initState();
  }

  displyAlert(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(message),
            ));
  }

  String result = "";

  getDeviceInfo() async {
    try {
      String output = await _mantraBiometricPlugin.getDeviceInformation() ?? "";
      result = output;
      setState(() {});
    } on RDClientNotFound catch (e) {
      displyAlert("Install Clinet");
    } catch (e) {
      displyAlert("Something Went Wrong $e");
    }
  }

  scanFingurePrint() async {
    try {
      String wadh = "E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=";
      String pidOptions =
          "<PidOptions ver=\"1.0\"> <Opts fCount=\"1\" fType=\"2\" pCount=\"0\" format=\"0\" pidVer=\"2.0\" wadh=\"$wadh\" timeout=\"20000\"  posh=\"UNKNOWN\" env=\"P\" /> </PidOptions>";
      result = await _mantraBiometricPlugin.captureFingurePrint(pidOptions: pidOptions) ?? "";
      
      setState(() {});
    } on RDClientNotFound catch (e) {
      log("${e.code}");
      displyAlert("Install Clinet");
    } catch (e) {
      displyAlert("Something Went Wrong $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mantra Biometric Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MaterialButton(
              onPressed: getDeviceInfo,
              child: const Text("Get Device Information"),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: scanFingurePrint,
              child: const Text("Scan Fingure Print"),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("$result")
          ],
        ),
      ),
    );
  }
}
