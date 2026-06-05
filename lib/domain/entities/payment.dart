class Payment {
  final String id;
  final String customerId;
  final double amount;
  final String mode;
  final DateTime date;
  final String? note;

  const Payment({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.mode,
    required this.date,
    this.note,
  });
}
