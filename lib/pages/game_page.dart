import 'package:flutter/material.dart';
import 'package:sudoku/widgets/timer_widget.dart';
import 'package:sudoku/widgets/tool_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String id = "/game";

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TimerWidget(),
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

                  // Determine the thickness of the borders
                  double topBorder = row % 3 == 0 ? 3.0 : 0.5;
                  double leftBorder = col % 3 == 0 ? 3.0 : 0.5;
                  double rightBorder = col == 8 ? 3.0 : 0.5;
                  double bottomBorder = row == 8 ? 3.0 : 0.5;

                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: topBorder, color: Colors.black),
                        left:
                            BorderSide(width: leftBorder, color: Colors.black),
                        right:
                            BorderSide(width: rightBorder, color: Colors.black),
                        bottom: BorderSide(
                            width: bottomBorder, color: Colors.black),
                      ),
                    ),
                    child: const Center(child: Text("")),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToolButton(
                icon: Icons.cleaning_services_outlined,
                label: "Erase",
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              9,
              (index) => Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(shape: const CircleBorder()),
                  onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
