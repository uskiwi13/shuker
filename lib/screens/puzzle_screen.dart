import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  Map<String, dynamic>? puzzleData;

  @override
  void initState() {
    super.initState();
    _loadPuzzle();
  }

  Future<void> _loadPuzzle() async {
    final String response =
        await rootBundle.loadString('assets/puzzles/game_1.json');
    setState(() {
      puzzleData = json.decode(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    // The background image container wraps the entire Scaffold
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Lets the background shine through
        appBar: AppBar(
          title: const Text('Puzzle #1'),
          backgroundColor: Colors.black54,
          elevation: 0,
        ),
        body: puzzleData == null
            ? const Center(child: CircularProgressIndicator())
            : _buildGrid(),
      ),
    );
  }

  Widget _buildGrid() {
    final List<dynamic> grid = puzzleData!['grid'];
    final int cols = puzzleData!['gridSize']['cols'];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1, // Keeps the grid a perfect square
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: grid.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemBuilder: (context, index) {
              final int cellValue = grid[index];
              final bool isBlackout = cellValue == 0;

              return Container(
                decoration: BoxDecoration(
                  color: isBlackout ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black87, width: 0.5),
                ),
                child: isBlackout
                    ? null
                    : Stack(
                        children: [
                          // The small number in the top left
                          Positioned(
                            top: 2,
                            left: 2,
                            child: Text(
                              cellValue.toString(),
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // The player's letter will go here eventually
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}