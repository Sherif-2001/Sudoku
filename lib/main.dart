import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/pages/game_page.dart';
import 'package:sudoku/pages/home_page.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: {TargetPlatform.android: ZoomPageTransitionsBuilder()}),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
                elevation: 5)),
        useMaterial3: true,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        GamePage.id: (context) => const GamePage()
      },
    );
  }
}
