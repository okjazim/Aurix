import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class GoldBalanceCard extends StatelessWidget {
  final double grams;
  final double eurValue;

  const GoldBalanceCard({
    super.key, 
    required this.grams, 
    required this.eurValue
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'gold_balance_hero', 
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryGold, AppColors.secondaryGold],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGold.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  const Text(
                    "Gold Savings",
                    style: TextStyle(
                      color: Colors.black54, 
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Icon(Icons.trending_up, color: Colors.black.withOpacity(0.5), size: 18),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${grams.toStringAsFixed(4)} g",
                style: const TextStyle(
                  color: Colors.black, 
                  fontSize: 36, 
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "≈ €${eurValue.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7), 
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}