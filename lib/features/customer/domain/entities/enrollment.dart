class Enrollment {
  final int id;
  final int? scheme;
  final String schemeName;
  final int? customer;
  final String? customerCode;
  final String? customerName;
  final String? customerPhone;
  final String? startDate;
  final String? endDate;
  final String status;
  final double totalPaid;
  final double balanceDue;
  final bool hasOverdue;
  final double maturityAmount;
  final double installmentAmount;
  final double totalSchemeAmount;
  final String? nextDueDate;
  final int totalInstallments;
  final int paidInstallments;
  final String? notes;
  final String? createdAt;

  const Enrollment({
    required this.id,
    this.scheme,
    required this.schemeName,
    this.customer,
    this.customerCode,
    this.customerName,
    this.customerPhone,
    this.startDate,
    this.endDate,
    required this.status,
    required this.totalPaid,
    required this.balanceDue,
    required this.hasOverdue,
    required this.maturityAmount,
    required this.installmentAmount,
    required this.totalSchemeAmount,
    this.nextDueDate,
    required this.totalInstallments,
    required this.paidInstallments,
    this.notes,
    this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Enrollment &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
