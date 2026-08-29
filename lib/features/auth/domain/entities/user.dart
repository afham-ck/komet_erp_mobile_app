class User {
  final int id;
  final String username;
  final String email;
  final String role;
  final int? storeId;
  final String? storeName;
  final String accessToken;
  final String refreshToken;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.storeId,
    this.storeName,
    required this.accessToken,
    required this.refreshToken,
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? role,
    int? storeId,
    String? storeName,
    String? accessToken,
    String? refreshToken,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
