import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // ← これを追加！

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'カッパの家計道場',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomeScreen(), // ← ここを変更！
    );
  }
}
