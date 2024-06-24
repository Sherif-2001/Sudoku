import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/models/sudoku_board.dart';
import 'package:sudoku/pages/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String id = "/home";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/puzzle2.png", height: 350),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(30),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Center(child: Text("Choose Difficulty")),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              Difficulty.values.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GamePage(
                                            difficulty:
                                                Difficulty.values[index]),
                                      ),
                                    );
                                  },
                                  child: Text(Difficulty.values[index].name
                                      .toUpperCase()),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: const Icon(Icons.play_arrow_rounded, size: 50),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(30),
                      ),
                      onPressed: () => SystemNavigator.pop(),
                      child: const Icon(Icons.logout, size: 50),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
