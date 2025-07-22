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
          title: const Text('스크롤 가능한 뷰 예제'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. ListView 예제
              const Text(
                '1. ListView (세로 스크롤 목록)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Icon(Icons.star, color: Colors.amber[700]),
                        title: Text('리스트 아이템 ${index + 1}'),
                        subtitle: Text('이것은 ${index + 1}번째 아이템입니다.'),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('아이템 ${index + 1} 클릭됨!')),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),

              // 2. GridView 예제
              const Text(
                '2. GridView (그리드 스크롤 목록)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 한 줄에 3개의 아이템
                    crossAxisSpacing: 10, // 가로 간격
                    mainAxisSpacing: 10, // 세로 간격
                  ),
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('그리드 아이템 ${index + 1} 클릭됨!')),
                        );
                      },
                      child: Container(
                        color: Colors.blue[100 * (index % 9)],
                        child: Center(
                          child: Text(
                            'Grid ${index + 1}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}