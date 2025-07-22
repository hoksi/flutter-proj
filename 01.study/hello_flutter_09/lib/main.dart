import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// 1. 상태를 관리할 모델 클래스 정의 (ChangeNotifier 상속)
class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // 상태 변경을 리스너들에게 알림
  }

  void decrement() {
    _count--;
    notifyListeners(); // 상태 변경을 리스너들에게 알림
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider 카운터 예제',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 2. 최상위 위젯에서 ChangeNotifierProvider를 통해 CounterModel 제공
      home: ChangeNotifierProvider(
        create: (context) => CounterModel(),
        child: const CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Consumer를 사용하여 상태 변화에 따라 특정 위젯만 리빌드
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 카운터 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '현재 카운터 값:',
              style: TextStyle(fontSize: 20),
            ),
            // context.watch<CounterModel>()를 사용하여 count 값 변화 감지
            Text(
              '${context.watch<CounterModel>().count}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // context.read<CounterModel>()를 사용하여 메서드 호출 (리빌드 X)
                    context.read<CounterModel>().increment();
                  },
                  child: const Text('증가'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterModel>().decrement();
                  },
                  child: const Text('감소'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}