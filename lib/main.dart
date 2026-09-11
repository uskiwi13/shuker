import 'package:flutter/material.dart';
import 'screens/puzzle_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization will go here later
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
        scaffoldBackgroundColor: Colors.transparent, // Crucial for global background image
      ),
      home: const PuzzleScreen(),
    );
  }
}