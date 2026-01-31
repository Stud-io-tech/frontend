import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fome/app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const AppWidget());
}
