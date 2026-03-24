class UserWallet {
  final double eurBalance;
  final double goldGrams;

  UserWallet({required this.eurBalance, required this.goldGrams});

  UserWallet copyWith({double? eurBalance, double? goldGrams}) {
    return UserWallet(
      eurBalance: eurBalance ?? this.eurBalance,
      goldGrams: goldGrams ?? this.goldGrams,
    );
  }
}