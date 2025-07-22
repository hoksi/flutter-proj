import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textEditingController = TextEditingController();
  String _displayText = '입력된 텍스트가 여기에 표시됩니다.';
  int _counter = 0;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('사용자 입력 처리 예제'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 1. TextField 위젯
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  labelText: '여기에 텍스트를 입력하세요',
                  border: OutlineInputBorder(),
                  hintText: '예: Flutter 학습',
                ),
                onChanged: (text) {
                  // 실시간으로 텍스트 변경 감지
                  // print('입력 중: $text');
                },
                onSubmitted: (text) {
                  // 엔터 키를 눌렀을 때 호출
                  setState(() {
                    _displayText = '입력 완료: $text';
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                _displayText,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),

              // 2. Button 계열 위젯
              const Text(
                '버튼 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter++;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('카운터 증가: $_counter')),
                      );
                    },
                    child: const Text('카운터 증가'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('카운터 초기화')),
                      );
                    },
                    child: const Text('카운터 초기화'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // 아무 동작 없음
                    },
                    child: const Text('아무것도 안 함'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '현재 카운터: $_counter',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}