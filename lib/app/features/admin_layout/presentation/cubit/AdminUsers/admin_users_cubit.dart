import 'package:aqar360/app/features/admin_layout/domain/usecases/get_all_data.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/update_user_block_status.dart';
import 'package:aqar360/app/features/admin_layout/presentation/cubit/AdminUsers/admin_users_state.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  AdminUsersCubit({
    required this.getAllUsersUsecase,
    required this.updateUserBlockStatus,
  }) : super(AdminUsersInitial());
  final UpdateUserBlockStatusUsecase updateUserBlockStatus;
  final GetAllUsersUsecase getAllUsersUsecase;
  static AdminUsersCubit get(BuildContext context) =>
      BlocProvider.of<AdminUsersCubit>(context);
  List<UserModel> _users = [];

  Future<void> fetchUsers() async {
    emit(AdminUsersLoading());

    try {
      final users = await getAllUsersUsecase();
      _users = users;

      emit(AdminUsersLoaded(users));
    } catch (e) {
      emit(AdminUsersError('Error fetching users: $e'));
    }
  }

  Future<void> toggleBlockStatus(UserModel user, bool isBlock) async {
    if (user.id == null) return;

    try {
      await updateUserBlockStatus(uid: user.id!, isBlock: isBlock);

      final index = _users.indexWhere((u) => u.id == user.id);

      if (index != -1) {
        _users[index] = UserModel(
          id: user.id,
          email: user.email,
          password: user.password,
          name: user.name,
          isBlock: isBlock,
          role: user.role,
        );
      }

      emit(AdminUsersLoaded(List.from(_users)));
    } catch (e) {
      emit(AdminUsersError('Error updating status: $e'));
    }
  }
}
