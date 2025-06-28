import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import '../widgets/kappa_comment.dart';
import 'transaction_input_screen.dart';
import 'monthly_summary_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> _transactions = [];
  final int target = 50000;

  int get totalSpent => _transactions
      .where((tx) => tx.type == TransactionType.expense)
      .fold(0, (sum, tx) => sum + tx.amount);

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
  void initState() {
    super.initState();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('transactions');
    if (jsonList != null) {
      setState(() {
        _transactions = jsonList
            .map((e) => Transaction.fromJson(json.decode(e)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("カッパの家計道場")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            KappaComment(
              message: generateKappaMessage(totalSpent, target),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionInputScreen(),
                  ),
                );
                await loadTransactions();
              },
              child: const Text("入力画面へ"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MonthlySummaryScreen(transactions: _transactions),
                  ),
                );
              },
              child: const Text("月別サマリーを見る"),
            ),
          ],
        ),
      ),
    );
  }
}
