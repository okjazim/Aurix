import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../models/transaction_model.dart';
import '../../../providers/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the list of transactions from the provider
    final transactions = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text(
                "No transactions yet",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                final isBuy = tx.type == TransactionType.buy;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isBuy ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    child: Icon(
                      isBuy ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isBuy ? Colors.green : Colors.red,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    isBuy ? "Bought Gold" : "Sold Gold",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    DateFormat('MMM dd, yyyy • HH:mm').format(tx.timestamp),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${isBuy ? '+' : '-'}${tx.goldGrams.toStringAsFixed(4)} g",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isBuy ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        "€${tx.eurAmount.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}