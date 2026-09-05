import 'package:komet_collection/features/customer/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    super.code,
    required super.name,
    required super.phone,
    super.email,
    super.address,
    super.aadhar,
    super.totalDue,
    super.overdueAmount,
    super.nextDueDate,
    super.isActive,
    super.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] != null ? json['id'].toString() : (json['customer_id']?.toString() ?? ''),
      code: json['code']?.toString() ?? json['customer_code']?.toString() ?? json['code_number']?.toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      address: json['address'],
      aadhar: json['aadhar'],
      totalDue: _parseDouble(json['total_due_amount'] ?? json['current_balance'] ?? json['total_due'] ?? json['outstanding_balance']),
      overdueAmount: _parseDouble(json['overdue_amount']),
      nextDueDate: json['next_due_date']?.toString(),
      isActive: json['is_active'] is bool ? json['is_active'] as bool : true,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'] as String? ?? '') : null,
    );
  }

  static double _parseDouble(dynamic val) {
    if (val == null) return 0.0;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val) ?? 0.0;
    return 0.0;
  }

  factory CustomerModel.fromEntity(Customer entity) {
    return CustomerModel(
      id: entity.id,
      code: entity.code,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      aadhar: entity.aadhar,
      totalDue: entity.totalDue,
      overdueAmount: entity.overdueAmount,
      nextDueDate: entity.nextDueDate,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
    );
  }

  Customer toEntity() {
    return Customer.fromModel(this);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'name': name,
    'phone': phone,
    'email': email,
    'address': address,
    'aadhar': aadhar,
    'total_due': totalDue,
    'overdue_amount': overdueAmount,
    'next_due_date': nextDueDate,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
  };
}
