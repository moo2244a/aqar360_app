class UserModel {
  final String email;
  final String password;
  final String? name;

  final bool? emailVerified;

  UserModel({
    required this.email,
    required this.password,
    this.name,
    this.emailVerified,
  });
}
