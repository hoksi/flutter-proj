import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('기본 위젯 예제'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 1. Text 위젯
              const Text(
                '안녕하세요, Flutter!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20), // 위젯 사이 간격

              // 2. Container 위젯
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Container 위젯',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Icon 위젯
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite, color: Colors.pink, size: 30.0),
                  SizedBox(width: 10),
                  Icon(Icons.audiotrack, color: Colors.green, size: 30.0),
                  SizedBox(width: 10),
                  Icon(Icons.beach_access, color: Colors.blue, size: 30.0),
                ],
              ),
              const SizedBox(height: 20),

              // 4. Image 위젯 (네트워크 이미지)
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}