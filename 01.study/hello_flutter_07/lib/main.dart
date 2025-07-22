import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '화면 이동 예제',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('첫 번째 화면'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('두 번째 화면으로 이동'),
          onPressed: () {
            // 두 번째 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('두 번째 화면'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('첫 번째 화면으로 돌아가기'),
          onPressed: () {
            // 이전 화면으로 돌아가기
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}