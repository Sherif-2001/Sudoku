import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  image: AssetImage("assets/images/back2.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/puzzle.png", height: 350),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, GamePage.id),
                      child: const Column(
                        children: [
                          Icon(Icons.play_arrow_rounded, size: 50),
                          Text("Play")
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () => SystemNavigator.pop(),
                      child: const Column(
                        children: [Icon(Icons.logout, size: 50), Text("Exit")],
                      ),
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
