// lib/utils/storage_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String keyTotalSpent = 'totalSpent';

  static Future<void> saveTotalSpent(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyTotalSpent, amount);
  }

  static Future<int> loadTotalSpent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyTotalSpent) ?? 0;
  }
}
