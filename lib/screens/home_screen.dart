import 'dart:async';
import 'dart:ffi';
// 언제 import 되었는지 모르겠는데
// 아래 임포트 된것때문에 디버그 에러 발생
// lib/screens/home_screen.dart:5:8: Error: Dart library 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart' is not available on this platform.
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
//        ^
// Context: The unavailable library 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart' is imported through these packages:
//     package:toonflix => dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart
// Detailed import paths for (some of) the these imports:
//     package:toonflix/main.dart => package:toonflix/screens/home_screen.dart => dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart
// lib/screens/home_screen.dart:5:8: Error: Dart library 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart' is not available on this platform.
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
//        ^
// Context: The unavailable library 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart' is imported through these packages:
//     package:toonflix => dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart
// Detailed import paths for (some of) the these imports:
//     package:toonflix/main.dart => package:toonflix/screens/home_screen.dart => dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart

// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    // Timer 라이브러리
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    if (isRunning) return;
    setState(() {
      totalSeconds = twentyFiveMinutes;
      // print('reset');
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    // print(duration.toString().split(".")[0].split("0:")[1]); ==25:00
    var durationToSting = duration.toString().split(".").first.substring(2);
    return durationToSting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 200,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(
                      isRunning
                          ? Icons.motion_photos_pause_sharp
                          : Icons.play_arrow_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: onResetPressed,
                    icon: Icon(
                      isRunning ? Icons.lock_reset_sharp : Icons.refresh_sharp,
                      color: Theme.of(context).cardColor,
                    ),
                    iconSize: 100,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 48,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
