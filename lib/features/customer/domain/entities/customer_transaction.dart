class PaymentClosed {
  final int installmentId;
  final int installmentNumber;
  final String? dueDate;
  final double installmentAmount;
  final double amountApplied;
  final String status;

  const PaymentClosed({
    required this.installmentId,
    required this.installmentNumber,
    this.dueDate,
    required this.installmentAmount,
    required this.amountApplied,
    required this.status,
  });
}

class CustomerTransaction {
  final int transactionId;
  final String receiptNo;
  final double amount;
  final String? paymentDate;
  final String paymentMode;
  final String receivedBy;
  final String? notes;
  final int? enrollmentId;
  final int? schemeId;
  final String? schemeName;
  final List<PaymentClosed> paymentsClosed;

  const CustomerTransaction({
    required this.transactionId,
    required this.receiptNo,
    required this.amount,
    this.paymentDate,
    required this.paymentMode,
    required this.receivedBy,
    this.notes,
    this.enrollmentId,
    this.schemeId,
    this.schemeName,
    this.paymentsClosed = const [],
  });
}
