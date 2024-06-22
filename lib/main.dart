import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 위젯 자체
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  void onclicked() {
    // setState를 호출할 때마다 build를 다시 실행함
    // 데이터 변화 counter를 꼭 setState에 넣을 필요는 없음 -- 변경되는 데이터를 setState 위에 올려두고 실행하면 굳이 setState에 넣지 않아도 변경된 데이터가 build에 적용됨
    // 그러나 가독성을 위해서는 setState 함수에 넣기
    setState(() {
      counter = counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click count',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '$counter',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              IconButton(
                iconSize: 40,
                onPressed: onclicked,
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
