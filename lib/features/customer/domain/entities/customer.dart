import 'package:komet_collection/features/customer/data/models/customer_model.dart';

class Customer {
  final String id;
  final String? code;
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final String? aadhar;
  final double totalDue;
  final DateTime? createdAt;

  const Customer({
    required this.id,
    this.code,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    this.aadhar,
    this.totalDue = 0.0,
    this.createdAt,
  });

  factory Customer.fromModel(CustomerModel model) {
    return Customer(
      id: model.id,
      code: model.code,
      name: model.name,
      phone: model.phone,
      email: model.email,
      address: model.address,
      aadhar: model.aadhar,
      totalDue: model.totalDue,
      createdAt: model.createdAt,
    );
  }

  CustomerModel toModel() {
    return CustomerModel(
      id: id,
      code: code,
      name: name,
      phone: phone,
      email: email,
      address: address,
      aadhar: aadhar,
      totalDue: totalDue,
      createdAt: createdAt,
    );
  }
}
