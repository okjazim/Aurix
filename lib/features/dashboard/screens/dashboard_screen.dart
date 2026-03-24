import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/wallet_provider.dart';
import '../widgets/gold_balance_card.dart';
import '../widgets/portfolio_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletProvider);
    final goldPrice = ref.watch(goldPriceProvider);
    final totalEurValue = wallet.goldGrams * goldPrice;

    return Scaffold(
      backgroundColor: AppColors.backgroundNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            // HERO TAG: Matches the tag in LoginScreen for a smooth transition
            Hero(
              tag: 'app_logo',
              child: Image.asset(
                'lib/assets/logo.png', 
                height: 30, // Scaled down for the AppBar
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "AURIX",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: AppColors.grey),
            onPressed: () => context.push('/history'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // 1. The Gold Balance Card
            GoldBalanceCard(
              grams: wallet.goldGrams,
              eurValue: totalEurValue,
            ),
            
            const SizedBox(height: 30),
            
            // 2. Portfolio Performance Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Portfolio Performance",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Live: €${goldPrice.toStringAsFixed(2)}/g",
                  style: const TextStyle(color: AppColors.primaryGold, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Bonus Chart Widget
            const PortfolioChart(), 
            
            const SizedBox(height: 30),
            
            // 3. Cash Balance Summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: Icon(Icons.euro, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Available Cash", 
                        style: TextStyle(color: AppColors.grey, fontSize: 12)
                      ),
                      Text(
                        "€${wallet.eurBalance.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // 4. Action Buttons (Buy and Sell)
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    label: "BUY",
                    icon: Icons.add,
                    color: AppColors.primaryGold,
                    onTap: () => context.push('/buy'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildActionButton(
                    context,
                    label: "SELL",
                    icon: Icons.remove,
                    color: Colors.white,
                    isOutlined: true,
                    onTap: () => context.push('/sell'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper widget for the Buy/Sell buttons
  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isOutlined = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : color,
          border: isOutlined ? Border.all(color: AppColors.primaryGold) : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, 
              color: isOutlined ? AppColors.primaryGold : Colors.black, 
              size: 20
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isOutlined ? AppColors.primaryGold : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}