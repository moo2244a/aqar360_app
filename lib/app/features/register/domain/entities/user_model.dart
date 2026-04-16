class UserModel {
  final String email;
  final String password;
  final String? name;

  UserModel({required this.email, required this.password, this.name});
}
