class TransactionModel {
  final String address;
  final int amount;
  final String description;
  final DateTime timestamp;

  TransactionModel(
    this.address,
    this.amount,
    this.description,
    this.timestamp,
  );
}
