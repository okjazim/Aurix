import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class StorageService {
  static const _eurKey = 'eur_balance';
  static const _goldKey = 'gold_balance';
  static const _authKey = 'is_logged_in';
  static const _historyKey = 'tx_history';

  // Auth: Persistent Session
  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authKey, value);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_authKey) ?? false;
  }

  // Balance
  Future<void> saveBalance(double eur, double gold) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_eurKey, eur);
    await prefs.setDouble(_goldKey, gold);
  }

  Future<Map<String, double>> loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'eur': prefs.getDouble(_eurKey) ?? 1000.0,
      'gold': prefs.getDouble(_goldKey) ?? 0.0,
    };
  }

  // History: Save List as JSON String
  Future<void> saveHistory(List<TransactionModel> history) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(history.map((x) => x.toMap()).toList());
    await prefs.setString(_historyKey, encoded);
  }

  Future<List<TransactionModel>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_historyKey);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((x) => TransactionModel.fromMap(x)).toList();
  }
}