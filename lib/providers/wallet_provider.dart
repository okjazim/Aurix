import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_wallet.dart';
import '../models/transaction_model.dart';
import '../services/storage_service.dart';
import 'history_provider.dart';

final goldPriceProvider = Provider<double>((ref) => 65.0);

class WalletNotifier extends StateNotifier<UserWallet> {
  final Ref ref;
  final StorageService _storage = StorageService();
  
  WalletNotifier(this.ref) : super(UserWallet(eurBalance: 1000.0, goldGrams: 0.0)) {
    _load();
  }

  Future<void> _load() async {
    final data = await _storage.loadBalance();
    state = UserWallet(eurBalance: data['eur']!, goldGrams: data['gold']!);
  }

  void buyGold(double eurAmount) {
    final currentPrice = ref.read(goldPriceProvider);
    if (state.eurBalance >= eurAmount) {
      double gramsToReceive = eurAmount / currentPrice;
      state = state.copyWith(
        eurBalance: state.eurBalance - eurAmount,
        goldGrams: state.goldGrams + gramsToReceive,
      );
      _storage.saveBalance(state.eurBalance, state.goldGrams);

      ref.read(historyProvider.notifier).addTransaction(
        type: TransactionType.buy,
        eur: eurAmount,
        grams: gramsToReceive,
      );
    }
  }

  void sellGold(double gramsToSell) {
    final currentPrice = ref.read(goldPriceProvider);
    if (state.goldGrams >= gramsToSell) {
      double eurToReceive = gramsToSell * currentPrice;
      state = state.copyWith(
        eurBalance: state.eurBalance + eurToReceive,
        goldGrams: state.goldGrams - gramsToSell,
      );
      _storage.saveBalance(state.eurBalance, state.goldGrams);

      ref.read(historyProvider.notifier).addTransaction(
        type: TransactionType.sell,
        eur: eurToReceive,
        grams: gramsToSell,
      );
    }
  }
}

final walletProvider = StateNotifierProvider<WalletNotifier, UserWallet>((ref) {
  return WalletNotifier(ref);
});