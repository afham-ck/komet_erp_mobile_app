class User {
  final String id;
  final String username;
  final String email;
  final String role;
  final int? storeId;
  final String? storeName;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.storeId,
    this.storeName,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'role': role,
        'store_id': storeId,
        'store_name': storeName,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'].toString(),
        username: json['username'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
        storeId: json['store_id'] as int?,
        storeName: json['store_name'] as String?,
      );
}
