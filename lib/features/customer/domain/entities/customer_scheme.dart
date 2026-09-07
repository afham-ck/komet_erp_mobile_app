class CustomerScheme {
  final int enrollmentId;
  final int schemeId;
  final String schemeName;
  final String durationType;
  final int durationCount;
  final int durationGapDays;
  final double installmentAmount;
  final double totalAmount;
  final double maturityAmount;
  final String? startDate;
  final String? endDate;
  final String? nextDueDate;
  final String status;
  final double totalPaid;
  final double balanceDue;
  final int totalInstallments;
  final int paidInstallments;
  final bool hasOverdue;
  final String? notes;
  final DateTime? createdAt;

  const CustomerScheme({
    required this.enrollmentId,
    required this.schemeId,
    required this.schemeName,
    required this.durationType,
    required this.durationCount,
    required this.durationGapDays,
    required this.installmentAmount,
    required this.totalAmount,
    required this.maturityAmount,
    this.startDate,
    this.endDate,
    this.nextDueDate,
    required this.status,
    required this.totalPaid,
    required this.balanceDue,
    required this.totalInstallments,
    required this.paidInstallments,
    required this.hasOverdue,
    this.notes,
    this.createdAt,
  });
}
