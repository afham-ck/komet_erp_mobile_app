class CustomerDetailEntity {
  final int id;
  final String customerCode;
  final String name;
  final String phone;
  final String? address;
  final String? email;
  final String? aadhar;
  final bool isActive;
  final double totalDueAmount;
  final double overdueAmount;
  final String? nextDueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CustomerDetailEntity({
    required this.id,
    required this.customerCode,
    required this.name,
    required this.phone,
    this.address,
    this.email,
    this.aadhar,
    this.isActive = true,
    this.totalDueAmount = 0.0,
    this.overdueAmount = 0.0,
    this.nextDueDate,
    this.createdAt,
    this.updatedAt,
  });
}
