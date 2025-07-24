import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 임포트
import 'screens/game_screen.dart';
import 'logic/game_logic.dart'; // GameLogic 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // GameLogic 인스턴스를 제공
      create: (context) => GameLogic(),
      child: MaterialApp(
        title: '2048 Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const GameScreen(),
      ),
    );
  }
}
