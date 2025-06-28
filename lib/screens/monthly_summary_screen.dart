import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class MonthlySummaryScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const MonthlySummaryScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // 月ごとの合計を計算
    final Map<String, Map<String, int>> monthlyData = {};

    for (var tx in transactions) {
      final monthKey = DateFormat('yyyy-MM').format(tx.date);
      monthlyData.putIfAbsent(monthKey, () => {'支出': 0, '収入': 0});

      if (tx.type == TransactionType.expense) {
        monthlyData[monthKey]!['支出'] = monthlyData[monthKey]!['支出']! + tx.amount;
      } else {
        monthlyData[monthKey]!['収入'] = monthlyData[monthKey]!['収入']! + tx.amount;
      }
    }

    final sortedKeys = monthlyData.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(title: const Text("月別サマリー")),
      body: ListView.builder(
        itemCount: sortedKeys.length,
        itemBuilder: (context, index) {
          final key = sortedKeys[index];
          final data = monthlyData[key]!;
          return ListTile(
            title: Text("$key"),
            subtitle: Text("支出: ¥${data['支出']}　収入: ¥${data['収入']}"),
          );
        },
      ),
    );
  }
}
