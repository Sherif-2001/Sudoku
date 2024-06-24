import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/models/sudoku_board.dart';
import 'package:sudoku/widgets/tool_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.difficulty});

  static const String id = "/game";
  final Difficulty difficulty;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late SudokuBoard sudokuBoard;
  int selectedRow = -1;
  int selectedCol = -1;
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  final _confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    _startStopwatch();
    sudokuBoard = SudokuBoard();
    sudokuBoard.generatePuzzle(widget.difficulty);
  }

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
  }

  void _toggleStopwatch() {
    _stopwatch.isRunning ? _stopwatch.stop() : _stopwatch.start();
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  void onNumberButtonPressed(int number) {
    final currentCell = sudokuBoard.board[selectedRow][selectedCol];
    currentCell.isInvalid = false;
    setState(() {
      if (selectedRow != -1 && selectedCol != -1 && !currentCell.isInitial) {
        currentCell.value = number;
        currentCell.isInvalid =
            !sudokuBoard.isValid(selectedRow, selectedCol, number);
      }
    });
  }

  void _restartGame() {
    setState(() {
      _stopwatch.reset();
      _startStopwatch();
      sudokuBoard.generatePuzzle(widget.difficulty); // Reset Sudoku board
      selectedRow = -1; // Reset selected cell
      selectedCol = -1;
    });
  }

  void showPauseDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      builder: (context) => AlertDialog(
        title: const Center(child: Text('Game Paused')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Time"),
            Text(
              _formatTime(_stopwatch.elapsedMilliseconds),
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.grey.shade800,
                      padding: EdgeInsets.zero),
                  onPressed: () {
                    _toggleStopwatch();
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.play_arrow),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.grey.shade800,
                      padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.home_rounded),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showGameCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                numberOfParticles: 100,
              ),
            ],
          ),
          AlertDialog(
            title: const Center(
              child: Text('Well Done!', style: TextStyle(fontSize: 30)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    const Text("Time"),
                    Text(
                      _formatTime(_stopwatch.elapsedMilliseconds),
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.grey.shade800,
                          padding: EdgeInsets.zero),
                      onPressed: () {
                        _restartGame();
                        _confettiController.stop();
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.restart_alt_rounded),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.grey.shade800,
                          padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.home_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.blue.shade900,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Sudoku",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text("Time"),
                  Text(
                    _formatTime(_stopwatch.elapsedMilliseconds),
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.grey.shade800,
                    padding: EdgeInsets.zero),
                onPressed: () {
                  _toggleStopwatch();
                  showPauseDialog();
                },
                child:
                    Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                itemCount: 81,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9),
                itemBuilder: (context, index) {
                  int row = index ~/ 9;
                  int col = index % 9;
                  final currentCell = sudokuBoard.board[row][col];

                  double topBorder = row % 3 == 0 ? 3.0 : 0.5;
                  double leftBorder = col % 3 == 0 ? 3.0 : 0.5;
                  double rightBorder = col == 8 ? 3.0 : 0.5;
                  double bottomBorder = row == 8 ? 3.0 : 0.5;

                  Color backgroundColor = currentCell.isInvalid
                      ? Colors.red.withOpacity(0.5) // Red if invalid
                      : (selectedRow == row || selectedCol == col)
                          ? Colors.lightBlueAccent.withOpacity(
                              (selectedRow == row && selectedCol == col)
                                  ? 0.8
                                  : 0.3)
                          : Colors.white;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRow = row;
                        selectedCol = col;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border(
                          top:
                              BorderSide(width: topBorder, color: Colors.black),
                          left: BorderSide(
                              width: leftBorder, color: Colors.black),
                          right: BorderSide(
                              width: rightBorder, color: Colors.black),
                          bottom: BorderSide(
                              width: bottomBorder, color: Colors.black),
                        ),
                      ),
                      child: FittedBox(
                        child: Center(
                          child: Text(
                              sudokuBoard.board[row][col].value == 0
                                  ? ''
                                  : sudokuBoard.board[row][col].value
                                      .toString(),
                              style: sudokuBoard.board[row][col].isInitial
                                  ? const TextStyle(color: Colors.black)
                                  : TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800])),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              9,
              (index) => Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(shape: const CircleBorder()),
                  onPressed: () {
                    onNumberButtonPressed(index + 1);

                    if (sudokuBoard.isGameComplete()) {
                      _confettiController.play();
                      _toggleStopwatch();
                      showGameCompleteDialog();
                    }
                  },
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ToolButton(
            icon: Icons.cleaning_services_outlined,
            label: "Erase",
            onPressed: () {
              setState(() {
                if (selectedRow != -1 && selectedCol != -1) {
                  final currentCell =
                      sudokuBoard.board[selectedRow][selectedCol];
                  if (!currentCell.isInitial) {
                    currentCell.value = 0;
                    currentCell.isInvalid = false;
                  }
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
