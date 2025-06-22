import 'package:flutter/material.dart';
import '../widgets/kappa_comment.dart';
import 'transaction_input_screen.dart'; // ← 忘れずにimport！

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final int totalSpent = 45600;
  final int target = 50000;

  String generateKappaMessage(int spent, int target) {
    if (spent <= target * 0.8) {
      return "いいペースじゃ！その調子！";
    } else if (spent <= target) {
      return "もう少しでゴールじゃ！気を抜くな！";
    } else {
      return "おぬし、やりすぎじゃないか！？";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("カッパの家計道場")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KappaComment(
              message: generateKappaMessage(totalSpent, target),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransactionInputScreen()),
                );
              },
              child: const Text("入力画面へ"),
            ),
          ],
        ),
      ),
    );
  }
}
