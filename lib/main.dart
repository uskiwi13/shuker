import 'package:flutter/material.dart';
import 'screens/startup_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ShukerApp());
}

class ShukerApp extends StatelessWidget {
  const ShukerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const StartupScreen(), // Changed to StartupScreen
    );
  }
}