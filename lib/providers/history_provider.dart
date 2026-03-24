import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction_model.dart';
import '../services/storage_service.dart';

class HistoryNotifier extends StateNotifier<List<TransactionModel>> {
  final StorageService _storage = StorageService();

  HistoryNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final savedHistory = await _storage.loadHistory();
    state = savedHistory;
  }

  void addTransaction({
    required TransactionType type,
    required double eur,
    required double grams,
  }) {
    final newTx = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      eurAmount: eur,
      goldGrams: grams,
      timestamp: DateTime.now(),
    );
    state = [newTx, ...state];
    _storage.saveHistory(state); // Persistant History
  }
}

final historyProvider = StateNotifierProvider<HistoryNotifier, List<TransactionModel>>((ref) {
  return HistoryNotifier();
});