import 'package:flutter/material.dart';
import 'package:hello_flutter_10/models/user_model.dart'; // User 모델 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '데이터 모델 예제',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // User 모델 객체 생성
  User _currentUser = User(
    name: '홍길동',
    age: 30,
    email: 'hong.gildong@example.com',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 프로필'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '이름: ${_currentUser.name}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '나이: ${_currentUser.age}세',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                '이메일: ${_currentUser.email}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // 데이터 업데이트 예시 (setState를 통해 UI 갱신)
                  setState(() {
                    _currentUser = User(
                      name: '김철수',
                      age: 25,
                      email: 'kim.chulsoo@example.com',
                    );
                  });
                },
                child: const Text('프로필 업데이트'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}