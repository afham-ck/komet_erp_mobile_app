class User {
  final String id;
  final String phone;
  final String? name;

  const User({
    required this.id,
    required this.phone,
    this.name,
  });
}
