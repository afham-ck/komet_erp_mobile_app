class Invoice {
  final String id;
  final DateTime date;
  final String items;
  final double amount;
  final double paid;
  final double balance;
  final bool isOverdue;

  const Invoice({
    required this.id,
    required this.date,
    required this.items,
    required this.amount,
    required this.paid,
    required this.balance,
    this.isOverdue = false,
  });
}
