import 'package:flutter/material.dart';
import 'package:fyp_mobile/app.dart';
import 'package:fyp_mobile/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const App());
}
