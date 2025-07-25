import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../utils/transaction_storage.dart';

class TransactionInputScreen extends StatefulWidget {
  const TransactionInputScreen({super.key});

  @override
  State<TransactionInputScreen> createState() => _TransactionInputScreenState();
}

class _TransactionInputScreenState extends State<TransactionInputScreen> {
  final _amountController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;

  void _saveTransaction() async {
    final amount = int.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    final newTransaction = Transaction(
      amount: amount,
      date: DateTime.now(),
      type: _selectedType,
    );

    final current = await TransactionStorage.loadTransactions();
    current.add(newTransaction);
    await TransactionStorage.saveTransactions(current);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("保存しました！")),
      );
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.pop(context, newTransaction);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("取引を追加")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "金額"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("種別："),
                Expanded(
                  child: ListTile(
                    title: const Text("支出"),
                    leading: Radio<TransactionType>(
                      value: TransactionType.expense,
                      groupValue: _selectedType,
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text("収入"),
                    leading: Radio<TransactionType>(
                      value: TransactionType.income,
                      groupValue: _selectedType,
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTransaction,
              child: const Text("保存する"),
            ),
          ],
        ),
      ),
    );
  }
}