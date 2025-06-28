import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class TransactionStorage {
  static const String _key = 'transactions';

  /// 取引データを保存する（List<String>として）
  static Future<void> saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = transactions.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  /// 保存された取引データを読み込む（List<Transaction>に変換）
  static Future<List<Transaction>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key);

    if (jsonList == null) return [];

    return jsonList.map((e) {
      final decoded = json.decode(e);
      return Transaction.fromJson(decoded);
    }).toList();
  }

  /// データを削除する（デバッグ用途など）
  static Future<void> clearTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
