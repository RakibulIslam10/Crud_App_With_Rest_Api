
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:restapicrudapp/MyAppAllDecoration.dart';

void main() => runApp(
  DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(), // Wrap your app
  ),
);