import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/wallet_provider.dart';

class BuyGoldScreen extends ConsumerStatefulWidget {
  const BuyGoldScreen({super.key});

  @override
  ConsumerState<BuyGoldScreen> createState() => _BuyGoldScreenState();
}

class _BuyGoldScreenState extends ConsumerState<BuyGoldScreen> {
  final TextEditingController _amountController = TextEditingController();
  double _calculatedGrams = 0.0;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    final price = ref.read(goldPriceProvider);
    final eur = double.tryParse(_amountController.text) ?? 0;
    final wallet = ref.read(walletProvider);

    setState(() {
      _calculatedGrams = eur / price;
      // Validation: Check if user has enough cash
      if (eur > wallet.eurBalance) {
        _errorText = "Insufficient EUR balance";
      } else {
        _errorText = null;
      }
    });
  }

  void _confirmPurchase() {
    final eur = double.tryParse(_amountController.text) ?? 0;
    if (eur > 0 && _errorText == null) {
      ref.read(walletProvider.notifier).buyGold(eur);
      context.pop(); // Go back to dashboard
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Purchase Successful!"), backgroundColor: AppColors.successGreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Buy Gold"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Balance: €${wallet.eurBalance.toStringAsFixed(2)}",
              style: const TextStyle(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: AppColors.primaryGold),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "€0.00",
                errorText: _errorText,
                border: InputBorder.none,
              ),
              autofocus: true,
            ),
            const SizedBox(height: 10),
            Text(
              "You will receive ≈ ${_calculatedGrams.toStringAsFixed(4)} g",
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: (_errorText == null && _calculatedGrams > 0) ? _confirmPurchase : null,
              child: const Text("CONFIRM PURCHASE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}