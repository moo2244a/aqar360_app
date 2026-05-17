import 'package:aqar360/app/core/constants/user_role.dart';

class UserModel {
  final String? id;
  final String email;
  final String password;
  final String? name;

  final bool? emailVerified;
  final bool? isBlock;
  UserRole? role;

  UserModel({
    required this.email,
    required this.password,
    this.name,
    this.emailVerified,
    this.role,
    this.id,
    this.isBlock,
  });
  Map<String, dynamic> toJson() {
    return {'role': role!.name, 'email': email, 'name': name, "isBlock": false};
  }
}
