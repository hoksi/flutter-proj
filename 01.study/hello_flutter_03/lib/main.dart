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
          title: const Text('레이아웃 위젯 예제'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. Row 위젯 예제
              const Text(
                '1. Row 위젯 (가로 배치)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // 가로 정렬
                  crossAxisAlignment: CrossAxisAlignment.center, // 세로 정렬
                  children: <Widget>[
                    Container(width: 50, height: 50, color: Colors.red),
                    Container(width: 50, height: 50, color: Colors.green),
                    Container(width: 50, height: 50, color: Colors.blue),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 2. Column 위젯 예제
              const Text(
                '2. Column 위젯 (세로 배치)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                width: double.infinity, // 부모 너비 전체 사용
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 세로 정렬
                  crossAxisAlignment: CrossAxisAlignment.center, // 가로 정렬
                  children: <Widget>[
                    Container(width: 50, height: 50, color: Colors.purple),
                    Container(width: 50, height: 50, color: Colors.orange),
                    Container(width: 50, height: 50, color: Colors.teal),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 3. Stack 위젯 예제
              const Text(
                '3. Stack 위젯 (겹쳐서 배치)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                width: 200,
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(width: 150, height: 150, color: Colors.yellow),
                    ),
                    Positioned(
                      left: 50,
                      top: 50,
                      child: Container(width: 150, height: 150, color: Colors.cyan),
                    ),
                    Positioned(
                      left: 100,
                      top: 100,
                      child: Container(width: 150, height: 150, color: Colors.lime),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 4. Expanded 위젯 예제 (Row/Column 내에서 공간 확장)
              const Text(
                '4. Expanded 위젯 (공간 확장)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                height: 100,
                child: Row(
                  children: <Widget>[
                    Container(width: 50, height: 50, color: Colors.brown),
                    Expanded(
                      child: Container(height: 50, color: Colors.pinkAccent),
                    ),
                    Container(width: 50, height: 50, color: Colors.indigo),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}