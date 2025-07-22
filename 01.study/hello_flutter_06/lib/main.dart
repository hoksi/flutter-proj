import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // http 패키지 임포트
import 'dart:convert'; // JSON 파싱을 위해 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _data = '데이터를 불러오는 중...';

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

      if (response.statusCode == 200) {
        // 성공적으로 데이터를 가져왔을 때
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _data = '제목: ${jsonResponse['title']}\n내용: ${jsonResponse['body']}';
        });
      } else {
        // 오류 발생 시
        setState(() {
          _data = '데이터 로드 실패: ${response.statusCode}';
        });
      }
    } catch (e) {
      // 네트워크 오류 등 예외 처리
      setState(() {
        _data = '오류 발생: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('외부 패키지 사용 예제 (HTTP)'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _data,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchData,
                child: const Text('데이터 불러오기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}