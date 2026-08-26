import 'package:komet_collection/features/customer/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
    required super.phone,
    super.email,
    super.address,
    super.aadhar,
    super.totalDue,
    super.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? json['customer_id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      address: json['address'],
      aadhar: json['aadhar'],
      totalDue: (json['total_due'] ?? json['outstanding_balance'] ?? 0).toDouble(),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  factory CustomerModel.fromEntity(Customer entity) {
    return CustomerModel(
      id: entity.id,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      aadhar: entity.aadhar,
      totalDue: entity.totalDue,
      createdAt: entity.createdAt,
    );
  }

  Customer toEntity() {
    return Customer.fromModel(this);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'address': address,
    'aadhar': aadhar,
    'total_due': totalDue,
    'created_at': createdAt?.toIso8601String(),
  };
}
