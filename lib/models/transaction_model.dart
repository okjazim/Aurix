enum TransactionType { buy, sell }

class TransactionModel {
  final String id;
  final TransactionType type;
  final double eurAmount;
  final double goldGrams;
  final DateTime timestamp;

  TransactionModel({
    required this.id,
    required this.type,
    required this.eurAmount,
    required this.goldGrams,
    required this.timestamp,
  });

  // Convert to Map for Storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type == TransactionType.buy ? 'buy' : 'sell',
      'eurAmount': eurAmount,
      'goldGrams': goldGrams,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Load from Map
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      type: map['type'] == 'buy' ? TransactionType.buy : TransactionType.sell,
      eurAmount: map['eurAmount'],
      goldGrams: map['goldGrams'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}