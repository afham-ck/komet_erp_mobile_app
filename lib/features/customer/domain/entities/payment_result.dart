class PaymentResult {
  final String status;
  final int transactionId;
  final String receiptNumber;
  final double amount;
  final String? paymentDate;
  final String paymentMode;
  final String? receivedBy;
  final String? createdByUsername;
  final int? createdById;
  final String? customerName;
  final String? schemeName;
  final List<int> installmentsFullyPaid;
  final List<int> installmentsPartiallyPaid;

  const PaymentResult({
    required this.status,
    required this.transactionId,
    required this.receiptNumber,
    required this.amount,
    this.paymentDate,
    required this.paymentMode,
    this.receivedBy,
    this.createdByUsername,
    this.createdById,
    this.customerName,
    this.schemeName,
    required this.installmentsFullyPaid,
    required this.installmentsPartiallyPaid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentResult &&
          runtimeType == other.runtimeType &&
          transactionId == other.transactionId &&
          receiptNumber == other.receiptNumber;

  @override
  int get hashCode => transactionId.hashCode ^ receiptNumber.hashCode;
}
