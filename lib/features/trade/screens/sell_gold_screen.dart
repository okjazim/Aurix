import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/wallet_provider.dart';

class SellGoldScreen extends ConsumerStatefulWidget {
  const SellGoldScreen({super.key});

  @override
  ConsumerState<SellGoldScreen> createState() => _SellGoldScreenState();
}

class _SellGoldScreenState extends ConsumerState<SellGoldScreen> {
  final TextEditingController _gramsController = TextEditingController();
  double _calculatedEur = 0.0;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _gramsController.addListener(_onGramsChanged);
  }

  void _onGramsChanged() {
  final price = ref.read(goldPriceProvider);
  final grams = double.tryParse(_gramsController.text) ?? 0;
  final wallet = ref.read(walletProvider);

  setState(() {
    _calculatedEur = grams * price;
    
    if (grams <= 0) {
      _errorText = "Enter a valid amount";
    } else if (grams > wallet.goldGrams) {
      _errorText = "Insufficient gold balance";
    } else if (_calculatedEur < 0.01) {
      _errorText = "Amount too small to sell"; // Prevents selling 0.0000001
    } else {
      _errorText = null;
    }
  });
}

  void _confirmSale() {
    final grams = double.tryParse(_gramsController.text) ?? 0;
    if (grams > 0 && _errorText == null) {
      ref.read(walletProvider.notifier).sellGold(grams);
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gold Sold Successfully!"), 
          backgroundColor: AppColors.successGreen
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Sell Gold"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Available: ${wallet.goldGrams.toStringAsFixed(4)} g",
              style: const TextStyle(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _gramsController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "0.00 g",
                errorText: _errorText,
                border: InputBorder.none,
              ),
              autofocus: true,
            ),
            const SizedBox(height: 10),
            Text(
              "You will receive ≈ €${_calculatedEur.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, color: AppColors.primaryGold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceDark,
                side: const BorderSide(color: AppColors.primaryGold),
                foregroundColor: AppColors.primaryGold,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: (_errorText == null && _calculatedEur > 0) ? _confirmSale : null,
              child: const Text("CONFIRM SALE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _gramsController.dispose();
    super.dispose();
  }
}