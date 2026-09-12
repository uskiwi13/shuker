import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GameMode { novice, intermediate, expert }

class PuzzleScreen extends StatefulWidget {
  final GameMode initialMode;
  
  const PuzzleScreen({Key? key, required this.initialMode}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  Map<String, dynamic>? puzzleData;
  Map<int, String> globalAnswers = {};
  Map<int, String> gridAnswersByIndex = {};

  late GameMode currentMode;
  bool showTimer = false; // Timer state

  @override
  void initState() {
    super.initState();
    currentMode = widget.initialMode; // Set mode from startup screen
    _loadPuzzle();
  }

  Future<void> _loadPuzzle() async {
    final String response = await rootBundle.loadString('assets/puzzles/game_1.json');
    final data = json.decode(response);

    final Map<String, dynamic> starters = data['starterLetters'];
    final Map<int, String> initialGlobal = {};
    final Map<int, String> initialGrid = {};
    
    final List<dynamic> grid = data['grid'];

    starters.forEach((key, value) {
      initialGlobal[int.parse(key)] = value.toString();
    });

    for (int i = 0; i < grid.length; i++) {
      if (grid[i] != 0 && initialGlobal.containsKey(grid[i])) {
        initialGrid[i] = initialGlobal[grid[i]]!;
      }
    }

    setState(() {
      puzzleData = data;
      globalAnswers = initialGlobal;
      gridAnswersByIndex = initialGrid;
    });
  }

  void _showSettingsOverlay() {
    // StatefulBuilder is required here so the Radio buttons update instantly inside the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text('Settings', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Show Timer', style: TextStyle(color: Colors.white)),
                    activeColor: Colors.blue,
                    value: showTimer,
                    onChanged: (bool value) {
                      setDialogState(() => showTimer = value);
                      setState(() => showTimer = value); // Update parent widget too
                    },
                  ),
                  const Divider(color: Colors.white24),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Difficulty Mode', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  ),
                  _buildSettingsRadio(GameMode.novice, 'Novice', setDialogState),
                  _buildSettingsRadio(GameMode.intermediate, 'Intermediate', setDialogState),
                  _buildSettingsRadio(GameMode.expert, 'Expert', setDialogState),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSettingsRadio(GameMode mode, String label, StateSetter setDialogState) {
    return RadioListTile<GameMode>(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      value: mode,
      groupValue: currentMode,
      activeColor: Colors.blue,
      onChanged: (GameMode? value) {
        if (value != null) {
          setDialogState(() => currentMode = value);
          setState(() => currentMode = value); // Update main game state
        }
      },
    );
  }

  // ... [Keep _handleGridTap, _handleCipherTap, and _checkExpertCipherCompletion unchanged] ...
  
  // Stubs for the tap handlers to keep the code compiling
  void _handleGridTap(int cellIndex, int cellNumber) {}
  void _handleCipherTap(int cellNumber) {}
  void _checkExpertCipherCompletion(int targetNumber) {}

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
        appBar: AppBar(
          backgroundColor: Colors.black54,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            onPressed: () {
              // TODO: Implement Stats Overlay
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Stats coming soon!')),
              );
            },
          ),
          title: const Text('Puzzle #1'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: _showSettingsOverlay,
            ),
          ],
        ),
        body: puzzleData == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (showTimer)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('00:00', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  Expanded(child: _buildGrid()),
                  _buildDecipherKey(),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }

  // ... [Keep _buildGrid, _buildDecipherKey, and _buildKeyRow unchanged from the previous code] ...

  Widget _buildGrid() { return Container(); /* Replace with previous _buildGrid */ }
  Widget _buildDecipherKey() { return Container(); /* Replace with previous _buildDecipherKey */ }
  Widget _buildKeyRow(int startNumber, int endNumber) { return Container(); /* Replace with previous _buildKeyRow */ }
}