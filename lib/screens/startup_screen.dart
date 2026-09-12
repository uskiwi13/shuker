import 'package:flutter/material.dart';
import 'puzzle_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  GameMode selectedMode = GameMode.intermediate; // Default to intermediate

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black87, // Dark overlay for readability
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome to Shuker',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choose your difficulty to begin:',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                _buildRadioOption(GameMode.novice, 'Novice', 'Auto-populates all matching numbers.'),
                _buildRadioOption(GameMode.intermediate, 'Intermediate', 'Auto-populates if added to the cipher.'),
                _buildRadioOption(GameMode.expert, 'Expert', 'Manual entry. Cipher unlocks when a number is fully solved.'),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PuzzleScreen(initialMode: selectedMode),
                      ),
                    );
                  },
                  child: const Text('Start Game', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(GameMode mode, String title, String subtitle) {
    return RadioListTile<GameMode>(
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      value: mode,
      groupValue: selectedMode,
      activeColor: Colors.blue,
      onChanged: (GameMode? value) {
        if (value != null) {
          setState(() {
            selectedMode = value;
          });
        }
      },
    );
  }
}