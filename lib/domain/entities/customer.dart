class Customer {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final double totalDue;
  final DateTime? createdAt;

  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    this.totalDue = 0.0,
    this.createdAt,
  });
}
