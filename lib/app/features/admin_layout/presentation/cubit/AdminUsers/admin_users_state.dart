import 'package:aqar360/app/features/login/data/models/user_model.dart';

abstract class AdminUsersState {}

class AdminUsersInitial extends AdminUsersState {}

class AdminUsersLoading extends AdminUsersState {}

class AdminUsersLoaded extends AdminUsersState {
  final List<UserModel> users;

  AdminUsersLoaded(this.users);
}

class AdminUsersError extends AdminUsersState {
  final String message;

  AdminUsersError(this.message);
}
